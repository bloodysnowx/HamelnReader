import Foundation
import RealmSwift

class OriginalWork: Object {
    dynamic var name: String = ""
    dynamic var value: String = ""
    let novels = List<Novel>()
    
    override static func primaryKey() -> String? { return "name" }
}
