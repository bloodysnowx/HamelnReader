import Foundation
import RealmSwift

class Chapter: Object {
    dynamic var novel: Novel?
    dynamic var episode: Episode?
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var preface: String = ""
    dynamic var text: String = ""
    dynamic var afterword: String = ""
    dynamic var lastUpdated: NSDate = NSDate()
    dynamic var read: Bool = false
    
    override static func primaryKey() -> String? { return "id" }
}
