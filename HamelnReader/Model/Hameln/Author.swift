import Foundation
import RealmSwift

class Author: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    let novels = List<Novel>()
    
    override static func primaryKey() -> String? { return "id" }
}
