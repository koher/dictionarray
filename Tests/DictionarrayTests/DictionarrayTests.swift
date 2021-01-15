import XCTest
import Dictionarray

final class DictionarrayTests: XCTestCase {
    func testInit() {
        do { // init()
            let a: Dictionarray<Foo> = []
            XCTAssertTrue(a.isEmpty)
        }
        do { // init(_: [Element])
            let a: Dictionarray<Foo> = .init([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ] as [Foo])
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
        do { // init<S>(_: S) where S: Sequence, S.Element == Element
            let a: Dictionarray<Foo> = .init([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ] as ArraySlice<Foo>)
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
        do { // init(arrayLiteral:)
            let a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
    }
    
    func testStartIndex() {
        do {
            let a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            XCTAssertEqual(a.startIndex, 0)
        }
        do { // empty
            let a: Dictionarray<Foo> = []
            XCTAssertEqual(a.startIndex, 0)
        }
    }
    
    func testEndIndex() {
        do {
            let a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            XCTAssertEqual(a.endIndex, 3)
        }
        do { // empty
            let a: Dictionarray<Foo> = []
            XCTAssertEqual(a.endIndex, 0)
        }
    }
    
    func testSubscript() {
        do { // get
            let a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
        }
        
        do { // set
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a[1] = Foo(id: "b", value: 7)
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "b", value: 7))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 7))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }

        do { // get and set
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a[1].value += 4
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "b", value: 7))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 7))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
        
        do { // set element with different id
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a[1] = Foo(id: "d", value: 7)
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "d", value: 7))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertNil(a["b"])
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
        }
        
        do { // set element with different existing id
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a[0] = Foo(id: "c", value: 7)
            XCTAssertEqual(a.count, 2)
            XCTAssertEqual(a[0], Foo(id: "c", value: 7))
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertNil(a["a"])
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 7))
        }

        do { // set element with different existing id (old index < new index)
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a[2] = Foo(id: "a", value: 7)
            XCTAssertEqual(a.count, 2)
            XCTAssertEqual(a[0], Foo(id: "b", value: 3))
            XCTAssertEqual(a[1], Foo(id: "a", value: 7))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 7))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertNil(a["c"])
        }

        do { // change id
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a[1].id = "d"
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "d", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertNil(a["b"])
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 3))
        }
    }
    
    func testSubscriptWithID() {
        let a: Dictionarray<Foo> = [
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
        ]
        
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        XCTAssertNil(a["d"])
    }
    
    func testSubscriptWithRange() {
        do { // Range
            let a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ]
            let r: DictionarraySlice<Foo> = a[1 ..< 4]
            XCTAssertEqual(r.count, 3)
            XCTAssertEqual(r.startIndex, 1)
            XCTAssertEqual(r.endIndex, 4)
            XCTAssertEqual(r[1], Foo(id: "b", value: 3))
            XCTAssertEqual(r[2], Foo(id: "c", value: 5))
            XCTAssertEqual(r[3], Foo(id: "d", value: 7))
            XCTAssertNil(r["a"])
            XCTAssertEqual(r["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(r["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(r["d"], Foo(id: "d", value: 7))
            XCTAssertNil(r["e"])
        }
        
        do { // general RangeExpression
            let a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ]
            let r: DictionarraySlice<Foo> = a[1 ... 3]
            XCTAssertEqual(r.count, 3)
            XCTAssertEqual(r.startIndex, 1)
            XCTAssertEqual(r.endIndex, 4)
            XCTAssertEqual(r[1], Foo(id: "b", value: 3))
            XCTAssertEqual(r[2], Foo(id: "c", value: 5))
            XCTAssertEqual(r[3], Foo(id: "d", value: 7))
            XCTAssertNil(r["a"])
            XCTAssertEqual(r["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(r["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(r["d"], Foo(id: "d", value: 7))
            XCTAssertNil(r["e"])
        }
        
        do { // UnboundRange
            let a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            let r: DictionarraySlice<Foo> = a[...]
            XCTAssertEqual(r.count, 3)
            XCTAssertEqual(r.startIndex, 0)
            XCTAssertEqual(r.endIndex, 3)
            XCTAssertEqual(r[0], Foo(id: "a", value: 2))
            XCTAssertEqual(r[1], Foo(id: "b", value: 3))
            XCTAssertEqual(r[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
    }
    
    func testAppend() {
        do {
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a.append(Foo(id: "d", value: 7))
            XCTAssertEqual(a.count, 4)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
        }
        
        do { // element with existing id
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a.append(Foo(id: "b", value: 7))
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "c", value: 5))
            XCTAssertEqual(a[2], Foo(id: "b", value: 7))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 7))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
    }
    
    func testInsert() {
        do {
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            a.insert(Foo(id: "d", value: 7), at: 1)
            XCTAssertEqual(a.count, 4)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "d", value: 7))
            XCTAssertEqual(a[2], Foo(id: "b", value: 3))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
        }
        
        do { // element with existing id
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ]
            a.insert(Foo(id: "d", value: 13), at: 1)
            XCTAssertEqual(a.count, 5)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "d", value: 13))
            XCTAssertEqual(a[2], Foo(id: "b", value: 3))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a[4], Foo(id: "e", value: 11))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 13))
            XCTAssertEqual(a["e"], Foo(id: "e", value: 11))
        }
        
        do { // element with existing id (old index < new index)
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ]
            a.insert(Foo(id: "b", value: 13), at: 4)
            XCTAssertEqual(a.count, 5)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "c", value: 5))
            XCTAssertEqual(a[2], Foo(id: "d", value: 7))
            XCTAssertEqual(a[3], Foo(id: "b", value: 13))
            XCTAssertEqual(a[4], Foo(id: "e", value: 11))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 13))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a["e"], Foo(id: "e", value: 11))
        }
    }
    
    func testPopLast() {
        var a: Dictionarray<Foo> = [
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
        ]
        
        XCTAssertEqual(a.popLast(), Foo(id: "c", value: 5))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[0], Foo(id: "a", value: 2))
        XCTAssertEqual(a[1], Foo(id: "b", value: 3))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertNil(a["c"])
        
        XCTAssertEqual(a.popLast(), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 1)
        XCTAssertEqual(a[0], Foo(id: "a", value: 2))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertNil(a["b"])
        
        XCTAssertEqual(a.popLast(), Foo(id: "a", value: 2))
        XCTAssertEqual(a.count, 0)
        XCTAssertNil(a["a"])
        
        XCTAssertNil(a.popLast())
    }
    
    func testPopElement() {
        do {
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            XCTAssertEqual(a.popElement(for: "b"), Foo(id: "b", value: 3))
            XCTAssertEqual(a.count, 2)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertNil(a["b"])
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
        do {
            var a: Dictionarray<Foo> = [
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
            ]
            XCTAssertNil(a.popElement(for: "d"))
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[0], Foo(id: "a", value: 2))
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
    }
    
    func testRemoveLast() {
        var a: Dictionarray<Foo> = [
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
        ]
        
        XCTAssertEqual(a.removeLast(), Foo(id: "c", value: 5))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[0], Foo(id: "a", value: 2))
        XCTAssertEqual(a[1], Foo(id: "b", value: 3))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertNil(a["c"])
        
        XCTAssertEqual(a.removeLast(), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 1)
        XCTAssertEqual(a[0], Foo(id: "a", value: 2))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertNil(a["b"])
        
        XCTAssertEqual(a.removeLast(), Foo(id: "a", value: 2))
        XCTAssertEqual(a.count, 0)
        XCTAssertNil(a["a"])
    }
    
    func testRemove() {
        var a: Dictionarray<Foo> = [
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
        ]
        XCTAssertEqual(a.remove(at: 1), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[0], Foo(id: "a", value: 2))
        XCTAssertEqual(a[1], Foo(id: "c", value: 5))
    }
    
    func testRemoveElement() {
        var a: Dictionarray<Foo> = [
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
        ]
        XCTAssertEqual(a.removeElement(for: "b"), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[0], Foo(id: "a", value: 2))
        XCTAssertEqual(a[1], Foo(id: "c", value: 5))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertNil(a["b"])
        XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
    }
    
    func testIterator() {
        let a: Dictionarray<Foo> = [
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
        ]
        var iterator = a.makeIterator()
        XCTAssertEqual(iterator.next(), Foo(id: "a", value: 2))
        XCTAssertEqual(iterator.next(), Foo(id: "b", value: 3))
        XCTAssertEqual(iterator.next(), Foo(id: "c", value: 5))
        XCTAssertNil(iterator.next())
    }
}

struct Foo: Identifiable, Equatable {
    var id: String
    var value: Int
}
