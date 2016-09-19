import Foundation
import RealmSwift
import RxSwift

class HamelnData {
    static let realm = try? Realm()
    
    static func author(id: Int, name: String) -> Author {
        if let author = realm?.object(ofType: Author.self, forPrimaryKey: id) { return author }
        
        let author = Author()
        author.id = id
        author.name = name
        try? realm?.write { realm?.add(author, update: true) }
        return author
    }
    
    static func originalWork(name: String) -> OriginalWork {
        if let work = realm?.object(ofType: OriginalWork.self, forPrimaryKey: name) { return work }
        
        let work = OriginalWork()
        work.name = name
        work.value = "原作：\(name)"
        try? realm?.write { realm?.add(work, update: true) }
        return work
    }
    
    static func originalWorks() -> Observable<[OriginalWork]> {
        if let works = realm?.objects(OriginalWork.self), works.count > 0 {
            var ary = [OriginalWork]()
            works.forEach { ary.append($0) }
            return Observable.just(ary)
        }
        return HamelnClient.originalWorks().do(onNext: { (works) in
            try? realm?.write { works.forEach { realm?.add($0, update: true) } }
        }, onError: nil, onCompleted: nil, onSubscribe: nil, onDispose: nil)
    }
    
    static func searchTypes() -> Observable<[SearchType]> {
        if let types = realm?.objects(SearchType.self), types.count > 0 {
            var ary = [SearchType]()
            types.forEach { ary.append($0) }
            return Observable.just(ary)
        }
        return HamelnClient.searchTypes().do(onNext: { (types) in
            try? realm?.write { types.forEach { realm?.add($0, update: true) } }
        }, onError: nil, onCompleted: nil, onSubscribe: nil, onDispose: nil)
    }
    
    static func tag(name: String) -> Tag {
        if let tag = realm?.object(ofType: Tag.self, forPrimaryKey: name) { return tag }
        
        let tag = Tag()
        tag.name = name
        try? realm?.write { realm?.add(tag, update: true) }
        return tag
    }
}
