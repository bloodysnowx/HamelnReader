import Foundation
import RealmSwift

class Status: Object {
    dynamic var name: String = ""
    
    override static func primaryKey() -> String? { return "name" }
}
