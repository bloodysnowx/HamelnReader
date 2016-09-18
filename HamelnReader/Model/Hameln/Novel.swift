import Foundation
import RealmSwift

class Novel: Object {
    let episodes = List<Episode>()
    let chapters = List<Chapter>()
    dynamic var chaptersCount: Int = 0
    dynamic var title: String = ""
    dynamic var id: Int = 0
    dynamic var synopsis: String = ""
    dynamic var started: NSDate = NSDate()
    dynamic var lastUpdated: NSDate = NSDate()
    dynamic var author: Author?
    dynamic var originalWork: OriginalWork?
    dynamic var ua: Int = 0
    dynamic var favoritesCount: Int = 0
    dynamic var adjustedAverage: Float = 0
    dynamic var totalEvaluation: Int = 0
    dynamic var averageEvaluation: Float = 0
    
    let tags = List<Tag>()
    
    override static func primaryKey() -> String? { return "id" }
}
