import Foundation
import RealmSwift

class Bookmark: Object {
    dynamic var chapter: Chapter?
    dynamic var date: Date = Date()
}
