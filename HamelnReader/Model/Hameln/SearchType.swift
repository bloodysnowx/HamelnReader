import Foundation
import RealmSwift

class SearchType: Object {
    dynamic var name: String = ""
    dynamic var value: Int = 0
    
    override static func primaryKey() -> String? { return "value" }
}
