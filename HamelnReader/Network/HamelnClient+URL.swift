import Foundation

extension HamelnClient {
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
        case Mode = "mode"
        case NovelId = "nid"
        case Keyword = "word"
    }
}
