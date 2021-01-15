import XCTest
import Dictionarray

final class DictionarraySliceTests: XCTestCase {
    func testInit() {
        func testInit() {
            do { // init()
                let a: DictionarraySlice<Foo> = []
                XCTAssertTrue(a.isEmpty)
            }
            do { // init(_: [Element])
                let a: DictionarraySlice<Foo> = .init([
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
                XCTAssertEqual(a.index(for: "a"), 0)
                XCTAssertEqual(a.index(for: "b"), 1)
                XCTAssertEqual(a.index(for: "c"), 2)
            }
            do { // init<S>(_: S) where S: Sequence, S.Element == Element
                let a: DictionarraySlice<Foo> = .init([
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
                XCTAssertEqual(a.index(for: "a"), 0)
                XCTAssertEqual(a.index(for: "b"), 1)
                XCTAssertEqual(a.index(for: "c"), 2)
            }
            do { // init(arrayLiteral:)
                let a: DictionarraySlice<Foo> = [
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
                XCTAssertEqual(a.index(for: "a"), 0)
                XCTAssertEqual(a.index(for: "b"), 1)
                XCTAssertEqual(a.index(for: "c"), 2)
            }
            do { // init(_: Dictionarray<Element>)
                let a: DictionarraySlice<Foo> = .init(Dictionarray<Foo>([
                    Foo(id: "a", value: 2),
                    Foo(id: "b", value: 3),
                    Foo(id: "c", value: 5),
                ] as [Foo]))
                XCTAssertEqual(a.count, 3)
                XCTAssertEqual(a[0], Foo(id: "a", value: 2))
                XCTAssertEqual(a[1], Foo(id: "b", value: 3))
                XCTAssertEqual(a[2], Foo(id: "c", value: 5))
                XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
                XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
                XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
                XCTAssertEqual(a.index(for: "a"), 0)
                XCTAssertEqual(a.index(for: "b"), 1)
                XCTAssertEqual(a.index(for: "c"), 2)
            }
        }
    }
    
    func testStartIndex() {
        do {
            let a: DictionarraySlice<Foo> = foos3
            XCTAssertEqual(a.startIndex, 1)
        }
        do { // empty
            let a: DictionarraySlice<Foo> = []
            XCTAssertEqual(a.startIndex, 0)
        }
    }
    
    func testEndIndex() {
        do {
            let a: DictionarraySlice<Foo> = foos3
            XCTAssertEqual(a.endIndex, 4)
        }
        do { // empty
            let a: DictionarraySlice<Foo> = []
            XCTAssertEqual(a.endIndex, 0)
        }
    }
    
    func testSubscript() {
        do { // get
            let a: DictionarraySlice<Foo> = foos3
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "b", value: 3))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
        }
        
        do { // set
            var a: DictionarraySlice<Foo> = foos3
            a[2] = Foo(id: "b", value: 7)
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "b", value: 7))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 7))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 2)
            XCTAssertEqual(a.index(for: "c"), 3)
        }

        do { // get and set
            var a: DictionarraySlice<Foo> = foos3
            a[2].value += 4
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "b", value: 7))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 7))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 2)
            XCTAssertEqual(a.index(for: "c"), 3)
        }
        
        do { // set element with different id
            var a: DictionarraySlice<Foo> = foos3
            a[2] = Foo(id: "d", value: 7)
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "d", value: 7))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertNil(a["b"])
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertNil(a.index(for: "b"))
            XCTAssertEqual(a.index(for: "c"), 3)
            XCTAssertEqual(a.index(for: "d"), 2)
        }
        
        do { // set element with different existing id
            var a: DictionarraySlice<Foo> = foos5
            a[2] = Foo(id: "d", value: 13)
            XCTAssertEqual(a.count, 4)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "d", value: 13))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a[4], Foo(id: "e", value: 11))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertNil(a["b"])
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 13))
            XCTAssertEqual(a["e"], Foo(id: "e", value: 11))
            XCTAssertEqual(a.index(for: "a"), 0)
            XCTAssertNil(a.index(for: "b"))
            XCTAssertEqual(a.index(for: "c"), 3)
            XCTAssertEqual(a.index(for: "d"), 2)
            XCTAssertEqual(a.index(for: "e"), 4)
        }

        do { // set element with different existing id (old index < new index)
            var a: DictionarraySlice<Foo> = foos5
            a[4] = Foo(id: "b", value: 13)
            XCTAssertEqual(a.count, 4)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a[3], Foo(id: "b", value: 13))
            XCTAssertEqual(a[4], Foo(id: "e", value: 11))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 13))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertNil(a["d"])
            XCTAssertEqual(a["e"], Foo(id: "e", value: 11))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 3)
            XCTAssertEqual(a.index(for: "c"), 2)
            XCTAssertNil(a.index(for: "d"))
            XCTAssertEqual(a.index(for: "e"), 4)
        }

        do { // change id
            var a: DictionarraySlice<Foo> = foos3
            a[2].id = "d"
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "d", value: 3))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertNil(a["b"])
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 3))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertNil(a.index(for: "b"))
            XCTAssertEqual(a.index(for: "c"), 3)
            XCTAssertEqual(a.index(for: "d"), 2)
        }
    }
    
    func testSubscriptWithID() {
        let a: DictionarraySlice<Foo> = foos3
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        XCTAssertNil(a["d"])
    }
    
    func testSubscriptWithRange() {
        do { // Range
            let a: DictionarraySlice<Foo> = foos5
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
            let a: DictionarraySlice<Foo> = foos5
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
            let a: DictionarraySlice<Foo> = foos3
            let r: DictionarraySlice<Foo> = a[...]
            XCTAssertEqual(r.count, 3)
            XCTAssertEqual(r.startIndex, 0)
            XCTAssertEqual(r.endIndex, 3)
            XCTAssertEqual(r[1], Foo(id: "a", value: 2))
            XCTAssertEqual(r[2], Foo(id: "b", value: 3))
            XCTAssertEqual(r[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        }
    }
    
    func testContainsElement() {
        let a: DictionarraySlice<Foo> = foos3
        XCTAssertTrue(a.containsElement(for: "a"))
        XCTAssertTrue(a.containsElement(for: "b"))
        XCTAssertTrue(a.containsElement(for: "c"))
        XCTAssertFalse(a.containsElement(for: "d"))
    }
    
    func testIndex() {
        let a: DictionarraySlice<Foo> = foos3
        XCTAssertEqual(a.index(for: "a"), 1)
        XCTAssertEqual(a.index(for: "b"), 2)
        XCTAssertEqual(a.index(for: "c"), 3)
        XCTAssertNil(a.index(for: "d"))
    }
    
    func testAppend() {
        do {
            var a: DictionarraySlice<Foo> = foos3
            a.append(Foo(id: "d", value: 7))
            XCTAssertEqual(a.count, 4)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "b", value: 3))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a[4], Foo(id: "d", value: 7))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 2)
            XCTAssertEqual(a.index(for: "c"), 3)
            XCTAssertEqual(a.index(for: "d"), 4)
        }
        
        do { // element with existing id
            var a: DictionarraySlice<Foo> = foos3
            a.append(Foo(id: "b", value: 7))
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a[3], Foo(id: "b", value: 7))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 7))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 3)
            XCTAssertEqual(a.index(for: "c"), 2)
        }
    }
    
    func testInsert() {
        do {
            var a: DictionarraySlice<Foo> = foos3
            a.insert(Foo(id: "d", value: 7), at: 2)
            XCTAssertEqual(a.count, 4)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "d", value: 7))
            XCTAssertEqual(a[3], Foo(id: "b", value: 3))
            XCTAssertEqual(a[4], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 3)
            XCTAssertEqual(a.index(for: "c"), 4)
            XCTAssertEqual(a.index(for: "d"), 2)
        }
        
        do { // element with existing id
            var a: DictionarraySlice<Foo> = foos5
            a.insert(Foo(id: "d", value: 13), at: 2)
            XCTAssertEqual(a.count, 5)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "d", value: 13))
            XCTAssertEqual(a[3], Foo(id: "b", value: 3))
            XCTAssertEqual(a[4], Foo(id: "c", value: 5))
            XCTAssertEqual(a[5], Foo(id: "e", value: 11))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 13))
            XCTAssertEqual(a["e"], Foo(id: "e", value: 11))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 3)
            XCTAssertEqual(a.index(for: "c"), 4)
            XCTAssertEqual(a.index(for: "d"), 2)
            XCTAssertEqual(a.index(for: "e"), 5)
        }
        
        do { // element with existing id (old index < new index)
            var a: DictionarraySlice<Foo> = foos5
            a.insert(Foo(id: "b", value: 13), at: 5)
            XCTAssertEqual(a.count, 5)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
            XCTAssertEqual(a[4], Foo(id: "b", value: 13))
            XCTAssertEqual(a[5], Foo(id: "e", value: 11))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 13))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a["e"], Foo(id: "e", value: 11))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 4)
            XCTAssertEqual(a.index(for: "c"), 2)
            XCTAssertEqual(a.index(for: "d"), 3)
            XCTAssertEqual(a.index(for: "e"), 5)
        }
    }
    
    func testPopLast() {
        var a: DictionarraySlice<Foo> = foos3
        
        XCTAssertEqual(a.popLast(), Foo(id: "c", value: 5))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[1], Foo(id: "a", value: 2))
        XCTAssertEqual(a[2], Foo(id: "b", value: 3))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertNil(a["c"])
        XCTAssertEqual(a.index(for: "a"), 1)
        XCTAssertEqual(a.index(for: "b"), 2)
        XCTAssertNil(a.index(for: "c"))

        XCTAssertEqual(a.popLast(), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 1)
        XCTAssertEqual(a[1], Foo(id: "a", value: 2))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertNil(a["b"])
        XCTAssertEqual(a.index(for: "a"), 1)
        XCTAssertNil(a.index(for: "b"))

        XCTAssertEqual(a.popLast(), Foo(id: "a", value: 2))
        XCTAssertEqual(a.count, 0)
        XCTAssertNil(a["a"])
        XCTAssertNil(a.index(for: "a"))

        XCTAssertNil(a.popLast())
    }
    
    func testPopElement() {
        do {
            var a: DictionarraySlice<Foo> = foos3
            XCTAssertEqual(a.popElement(for: "b"), Foo(id: "b", value: 3))
            XCTAssertEqual(a.count, 2)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertNil(a["b"])
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertNil(a.index(for: "b"))
            XCTAssertEqual(a.index(for: "c"), 2)
        }
        do {
            var a: DictionarraySlice<Foo> = foos3
            XCTAssertNil(a.popElement(for: "d"))
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "a", value: 2))
            XCTAssertEqual(a[2], Foo(id: "b", value: 3))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a.index(for: "a"), 1)
            XCTAssertEqual(a.index(for: "b"), 2)
            XCTAssertEqual(a.index(for: "c"), 3)
        }
    }
    
    func testRemoveLast() {
        var a: DictionarraySlice<Foo> = foos3
        
        XCTAssertEqual(a.removeLast(), Foo(id: "c", value: 5))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[1], Foo(id: "a", value: 2))
        XCTAssertEqual(a[2], Foo(id: "b", value: 3))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertNil(a["c"])
        XCTAssertEqual(a.index(for: "a"), 1)
        XCTAssertEqual(a.index(for: "b"), 2)
        XCTAssertNil(a.index(for: "c"))

        XCTAssertEqual(a.removeLast(), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 1)
        XCTAssertEqual(a[1], Foo(id: "a", value: 2))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertNil(a["b"])
        XCTAssertEqual(a.index(for: "a"), 1)
        XCTAssertNil(a.index(for: "b"))

        XCTAssertEqual(a.removeLast(), Foo(id: "a", value: 2))
        XCTAssertEqual(a.count, 0)
        XCTAssertNil(a["a"])
        XCTAssertNil(a.index(for: "a"))
    }
    
    func testRemove() {
        var a: DictionarraySlice<Foo> = foos3
        XCTAssertEqual(a.remove(at: 2), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[1], Foo(id: "a", value: 2))
        XCTAssertEqual(a[2], Foo(id: "c", value: 5))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertNil(a["b"])
        XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        XCTAssertEqual(a.index(for: "a"), 1)
        XCTAssertNil(a.index(for: "b"))
        XCTAssertEqual(a.index(for: "c"), 2)
    }
    
    func testRemoveElement() {
        var a: DictionarraySlice<Foo> = foos3
        XCTAssertEqual(a.removeElement(for: "b"), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[1], Foo(id: "a", value: 2))
        XCTAssertEqual(a[2], Foo(id: "c", value: 5))
        XCTAssertEqual(a["a"], Foo(id: "a", value: 2))
        XCTAssertNil(a["b"])
        XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        XCTAssertEqual(a.index(for: "a"), 1)
        XCTAssertNil(a.index(for: "b"))
        XCTAssertEqual(a.index(for: "c"), 2)
    }
    
    func testIterator() {
        let a: DictionarraySlice<Foo> = foos3
        var iterator = a.makeIterator()
        XCTAssertEqual(iterator.next(), Foo(id: "a", value: 2))
        XCTAssertEqual(iterator.next(), Foo(id: "b", value: 3))
        XCTAssertEqual(iterator.next(), Foo(id: "c", value: 5))
        XCTAssertNil(iterator.next())
    }
}

private let foos3: DictionarraySlice<Foo> = ([
    Foo(id: "x", value: -1),
    Foo(id: "a", value: 2),
    Foo(id: "b", value: 3),
    Foo(id: "c", value: 5),
    Foo(id: "y", value: -2),
] as Dictionarray<Foo>)[1 ..< 4]
private let foos5: DictionarraySlice<Foo> = ([
    Foo(id: "x", value: -1),
    Foo(id: "a", value: 2),
    Foo(id: "b", value: 3),
    Foo(id: "c", value: 5),
    Foo(id: "d", value: 7),
    Foo(id: "e", value: 11),
    Foo(id: "y", value: -2),
] as Dictionarray<Foo>)[1 ..< 6]
