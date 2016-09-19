import XCTest
import RxBlocking

@testable import HamelnReader

class HamelnClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearch() {
        let searchType = SearchType()
        searchType.value = 28
        let originalWork = OriginalWork()
        originalWork.value = "原作:オーバーロード"
        guard let results = (try? HamelnClient.search(searchType: searchType, originalWork: originalWork).toBlocking().first()).flatMap({ $0 }) else { return XCTFail("results should not be nil.") }
        XCTAssertEqual(results.count, 10)
        XCTAssertNotNil(results.first(where: { (novel) -> Bool in novel.title.contains("モモンガ様ひとり旅") }))
        XCTAssertNotNil(results.first(where: { (novel) -> Bool in novel.chaptersCount == 21 }))
        XCTAssertNotNil(results.first(where: { (novel) -> Bool in novel.charactersCount == 412197 }))
        XCTAssertNotNil(results.first(where: { (novel) -> Bool in novel.id == 63139 }))
        XCTAssertNotNil(results.first(where: { (novel) -> Bool in novel.synopsis.contains("モモンガ様、ぼっちで異世界トリップなう。") }))
    }
    
    func testChapter() {
        guard let chapter = (try? HamelnClient.chapter(novelId: 84042, chapterId: 1).toBlocking().first()).flatMap({ $0 }) else { return XCTFail("chapter should not be nil.") }
        XCTAssertEqual(chapter.id, 1)
        XCTAssertTrue(chapter.preface.contains("初投稿です。"))
        XCTAssertTrue(chapter.text.contains("モモンガ"))
        XCTAssertTrue(chapter.afterword.contains("最後までお読み頂き、本当にありがとうございました！"))
    }
    
    func testSearchTypes() {
        guard let types = (try? HamelnClient.searchTypes().toBlocking().first()).flatMap({ $0 }) else { return XCTFail("types should not be nil.") }
        XCTAssertGreaterThanOrEqual(types.count, 35)
        XCTAssertNotNil(types.first(where: { (type) -> Bool in type.name.contains("総合評価") && type.value == 28 }))
    }
    
    func testOriginalWorks() {
        guard let works = (try? HamelnClient.originalWorks().toBlocking().first()).flatMap({ $0 }) else { return XCTFail("works should not be nil.") }
        XCTAssertGreaterThanOrEqual(works.count, 67)
        XCTAssertNotNil(works.first(where: { (work) -> Bool in work.name.contains("オーバーロード") && work.value.contains("オーバーロード") }))
    }
}
