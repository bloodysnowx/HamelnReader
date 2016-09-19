import Foundation
import RealmSwift

class History: Object {
    dynamic var chapter: Chapter?
    dynamic var date: Date = Date()
}
