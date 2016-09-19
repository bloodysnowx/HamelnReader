import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import Kanna

class HamelnClient {
    static func search(searchType: SearchType, originalWork: String = "", keyword: String = "") {
        let parameters: Parameters = [Param.OriginalWork.rawValue: originalWork, Param.SearchType.rawValue: searchType.value, Param.Keyword.rawValue: keyword]
        Alamofire.request(URL.Search.getUrl(), parameters: parameters).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
    
    static func novel(novelId: Int) {
        Alamofire.request(URL.NovelUrl(novelId: novelId)).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
    
    static func novelDetail(novelId: Int) {
        let parameters: Parameters = [Param.Mode.rawValue: "ss_detail", Param.NovelId.rawValue: novelId]
        Alamofire.request(URL.Base.getUrl(), parameters: parameters).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
    
    static func chapter(novelId: Int, chapter: Int) {
        Alamofire.request(URL.ChapterUrl(novelId: novelId, chapter: chapter)).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
    
    static func originalWorks() -> Observable<[OriginalWork]> {
        let parameters: [String: AnyObject] = [Param.Mode.rawValue: "search" as AnyObject]
        return requestString(.get, URL.Base.getUrl(), parameters: parameters).map { (response, str) -> [OriginalWork] in
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
        return requestString(.get, URL.Base.getUrl(), parameters: parameters).map { (response, str) -> [SearchType] in
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
}
