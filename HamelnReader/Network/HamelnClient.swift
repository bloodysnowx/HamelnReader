import Foundation
import Alamofire
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
    
    static func originalWorks() {
        // #main > div:nth-child(1) > form > div > table > tbody > tr:nth-child(2) > td:nth-child(2) > select > option
        let parameters: Parameters = [Param.Mode.rawValue: "search"]
        Alamofire.request(URL.Base.getUrl(), parameters: parameters).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
    
    static func searchTypes() {
        // #main > div:nth-child(1) > form > div > table > tbody > tr:nth-child(2) > td:nth-child(4) > select > option
        let parameters: Parameters = [Param.Mode.rawValue: "search"]
        Alamofire.request(URL.Base.getUrl(), parameters: parameters).responseString { (response) in
            if let str = response.result.value { print(str) }
        }
    }
}
