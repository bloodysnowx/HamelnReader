import Foundation

extension HamelnClient {
    enum URL: String {
        case Base = "https://syosetu.org"
        case Novel = "https://novel.syosetu.org"
        case Search = "https://search.syosetu.org"
        
        static func NovelUrl(novelId: Int) -> String {
            return "\(URL.Novel.rawValue)/\(novelId)/"
        }
        
        static func ChapterUrl(novelId: Int, chapterId: Int) -> String {
            return "\(URL.NovelUrl(novelId: novelId))\(chapterId).html"
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
