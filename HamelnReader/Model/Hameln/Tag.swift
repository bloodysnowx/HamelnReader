import Foundation
import RealmSwift

class Tag: Object {
    dynamic var name: String = ""
    let novels = List<Novel>()
    
    override static func primaryKey() -> String? { return "name" }
}
