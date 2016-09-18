import UIKit
import Alamofire

class HamelnClient {
    enum URL: String {
        case Base = "https://search.syosetu.org/"
        case Search = ""
        
        func getUrl() -> String {
            if self == .Base { return self.rawValue }
            return "\(URL.Base.rawValue)\(self.rawValue)"
        }
        
        static func NovelUrl(novelId: Int) -> String {
            return "\(URL.Base.rawValue)\(novelId)/"
        }
        
        static func ChapterUrl(novelId: Int, chapter: Int) -> String {
            return "\(URL.NovelUrl(novelId: novelId))\(chapter).html"
        }
    }
    
    enum Param: String {
        case OriginalWork = "gensaku"
        case SearchType = "type"
    }
    
    enum SearchType: Int {
        case LastModifiedAsc = 0
        case LastModifiedDesc = 1
        case ComprehensiveEvaluation = 28
    }
    
    // #main > div:nth-child(1) > form > div > table > tbody > tr:nth-child(2) > td:nth-child(2) > select > option
    // #main > div:nth-child(1) > form > div > table > tbody > tr:nth-child(2) > td:nth-child(4) > select > option
    
    static func search(originalWork: String, searchType: SearchType = .ComprehensiveEvaluation) {
        let parameters: Parameters = [Param.OriginalWork.rawValue: originalWork, Param.SearchType.rawValue: searchType.rawValue]
        Alamofire.request(URL.Search.getUrl(), parameters: parameters).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
    
    static func novel(novelId: Int) {
        Alamofire.request(URL.NovelUrl(novelId: novelId)).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
    
    static func chapter(novelId: Int, chapter: Int) {
        Alamofire.request(URL.ChapterUrl(novelId: novelId, chapter: chapter)).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
}
