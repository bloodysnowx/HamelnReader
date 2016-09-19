import Foundation
import RealmSwift

class RankingType: Object {
    dynamic var name: String = ""
    dynamic var value: String = ""
    
    override static func primaryKey() -> String? { return "value" }
}

class SSRankingType: Object {
    dynamic var name: String = ""
    dynamic var value: String = ""
    
    override static func primaryKey() -> String? { return "value" }
}
