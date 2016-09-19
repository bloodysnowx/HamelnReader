import Foundation

class HamelnData {
    static func author(id: Int, name: String) -> Author {
        return Author()
    }
    
    static func originalWork(name: String) -> OriginalWork {
        return OriginalWork()
    }
    
    static func tag(name: String) -> Tag {
        return Tag()
    }
}
