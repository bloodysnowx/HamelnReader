import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import Kanna

class HamelnClient {
    static let lastUpdatedFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
    
    static func search(searchType: SearchType, originalWork: OriginalWork?, keyword: String = "", page: Int = 1) -> Observable<[Novel]> {
        let parameters: [String: AnyObject] = [Param.OriginalWork.rawValue: originalWork?.value as AnyObject? ?? "" as AnyObject, Param.SearchType.rawValue: searchType.value as AnyObject, Param.Keyword.rawValue: keyword as AnyObject, Param.Page.rawValue: page as AnyObject, Param.Mode.rawValue: "search" as AnyObject]
        return requestString(.get, URL.Search.rawValue, parameters: parameters).map { (response, str) -> [Novel] in
            guard let html = Kanna.HTML(html: str, encoding: .utf8) else { throw BSError.DataDownloadError }
            let sections = html.css(".section3")
            return sections.flatMap({ (elem) -> Novel? in
                guard let title = elem.css("div.blo_title_base > a").flatMap({ $0.innerHTML }).first,
                let originalWork = elem.css("div.blo_title_base > div > a:nth-child(1)").flatMap({ $0.innerHTML }).first,
                let author = elem.css("div.blo_title_base > div > a:nth-child(2)").flatMap({ $0.innerHTML }).first,
                let chaptersCount = elem.css("div.blo_wasuu_base > a > b").flatMap({ $0.innerHTML }).first.flatMap({ Int($0) }),
                let charactersCount = elem.css("div.blo_wasuu_base > div").flatMap({ $0.innerHTML }).first.flatMap({ Int($0.removingOccurrences(ary: [" ", ",", "全", "字"])) }),
                let novelIdStr = elem["id"]?.removingOccurrences(ary: ["nid_"]), let novelId = Int(novelIdStr),
                let synopsis = elem.css("div.all_base.all_arasuji > div.blo_inword").flatMap({ $0.innerHTML }).first,
                let lastUpdatedStr = elem.css("div.blo_date").flatMap({ $0.innerHTML }).first?.removingOccurrences(ary: ["</div>", " ", "\n"]).replacingOccurrences(of: "<div>", with: " "),
                let lastUpdated = lastUpdatedFormatter.date(from: lastUpdatedStr),
                let adjustedAverageStr = elem.css("div.blo_hyouka > div.blo_mix").flatMap({ $0.innerHTML }).first?.components(separatedBy: "：").last?.removingOccurrences(ary: [" ", "\n"]),
                let adjustedAverage = Float(adjustedAverageStr)
                    else { return nil }
                
                let novel = Novel()
                novel.title = title
                // novel.originalWork
                // novel.author
                novel.chaptersCount = chaptersCount
                novel.charactersCount = charactersCount
                novel.id = novelId
                novel.synopsis = synopsis
                novel.lastUpdated = lastUpdated
                // novel.ua
                // novel.favoritesCount
                novel.adjustedAverage = adjustedAverage
                // novel.tags
                return novel
            })
        }
    }
    
    static func novel(novelId: Int) {
        requestString(.get, URL.NovelUrl(novelId: novelId))
    }
    
    static func novelDetail(novelId: Int) {
        let parameters: [String: AnyObject] = [Param.Mode.rawValue: "ss_detail" as AnyObject, Param.NovelId.rawValue: novelId as AnyObject]
        requestString(.get, URL.Base.rawValue, parameters: parameters)
    }
    
    static func chapter(novelId: Int, chapterId: Int) -> Observable<Chapter> {
        return requestString(.get, URL.ChapterUrl(novelId: novelId, chapterId: chapterId)).map { (response, str) -> Chapter in
            guard let html = Kanna.HTML(html: str, encoding: .utf8),
            // let title = html.css("#maind > div:nth-child(1) > p > span > a").flatMap({ $0.innerHTML }).first,
            /* let author = html.css("#maind > div:nth-child(1) > p > a:nth-child(2)").flatMap({ (elem) -> Author? in
                guard let authorIdStr = elem["href"]?.components(separatedBy: "=").last, let authorId = Int(authorIdStr), let name = elem.innerHTML else { return nil }
                let author = Author()
                author.id = authorId
                author.name = name
                return author
            }).first, */
            let preface = html.css("#maegaki").flatMap({ $0.innerHTML }).first,
            let text = html.css("#honbun").flatMap({ $0.innerHTML }).first,
            let afterword = html.css("#atogaki").flatMap({ $0.innerHTML }).first
                else { throw BSError.DataDownloadError }
            let chapter = Chapter()
            chapter.id = chapterId
            // chapter.title = title
            chapter.preface = preface
            chapter.text = text
            chapter.afterword = afterword
            return chapter
        }
    }
    
    static func originalWorks() -> Observable<[OriginalWork]> {
        let parameters: [String: AnyObject] = [Param.Mode.rawValue: "search" as AnyObject]
        return requestString(.get, URL.Search.rawValue, parameters: parameters).map { (response, str) -> [OriginalWork] in
            guard let html = Kanna.HTML(html: str, encoding: .utf8) else { return [] }
            let options = html.css("#main > div:nth-child(1) > form > div > table > tbody > tr:nth-child(2) > td:nth-child(2) > select > option")
            return options.flatMap({ (elem) -> OriginalWork? in
                guard let value = elem["value"], let name = elem.innerHTML, value.characters.count > 0, name.characters.count > 0 else { return nil }
                let work = OriginalWork()
                work.value = value
                work.name = name
                return work
            })
        }
    }
    
    static func searchTypes() -> Observable<[SearchType]> {
        let parameters: [String: AnyObject] = [Param.Mode.rawValue: "search" as AnyObject]
        return requestString(.get, URL.Search.rawValue, parameters: parameters).map { (response, str) -> [SearchType] in
            guard let html = Kanna.HTML(html: str, encoding: .utf8) else { return [] }
            let options = html.css("#main > div:nth-child(1) > form > div > table > tbody > tr:nth-child(2) > td:nth-child(4) > select > option")
            return options.flatMap({ (elem) -> SearchType? in
                guard let valueStr = elem["value"], let name = elem.innerHTML, valueStr.characters.count > 0, name.characters.count > 0, let value = Int(valueStr) else { return nil }
                let type = SearchType()
                type.value = value
                type.name = name
                return type
            })
        }
    }
    
    static func ranking() {
        
    }
    
    static func ssRanking() {
        
    }
    
    static func rankingTypes() {
        
    }
    
    static func ssRankingTypes() {
        
    }
}
