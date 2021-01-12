import XCTest
@testable import Dictionarray

final class DictionarrayTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Dictionarray().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
