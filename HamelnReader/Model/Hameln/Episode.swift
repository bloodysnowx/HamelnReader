import Foundation
import RealmSwift

class Episode: Object {
    dynamic var name: String = ""
    dynamic var novel: Novel?
    let chapters = List<Chapter>()
}
