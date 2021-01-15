import XCTest
import Dictionarray

final class Demo: XCTest {
    func testDemo() {
        var users: Dictionarray<User> = [
            User(id: "aaa", name: "Chris"),
            User(id: "bbb", name: "Rob"),
            User(id: "ccc", name: "Graydon"),
        ]
        
        // All following operations run in O(1).
        print(users[0].name)          // Chris
        print(users[id: "aaa"]!.name) // Chris
        
        users.append(User(id: "ddd", name: "Martin"))
        
        XCTAssertEqual(users.count, 4)
    }
}

private struct User: Identifiable {
    let id: String
    var name: String
}
