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
            }
        }
    }
    
    func testStartIndex() {
        do {
            let a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            XCTAssertEqual(a.startIndex, 1)
        }
        do { // empty
            let a: DictionarraySlice<Foo> = []
            XCTAssertEqual(a.startIndex, 0)
        }
    }
    
    func testEndIndex() {
        do {
            let a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            XCTAssertEqual(a.endIndex, 4)
        }
        do { // empty
            let a: DictionarraySlice<Foo> = []
            XCTAssertEqual(a.endIndex, 0)
        }
    }
    
    func testSubscript() {
        do { // get
            let a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
        }
        
        do { // set
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a[2] = Foo(id: "c", value: 13)
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 13))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 13))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
        }

        do { // get and set
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a[2].value += 8
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 13))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 13))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
        }
        
        do { // set element with different id
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a[2] = Foo(id: "f", value: 13)
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "f", value: 13))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertNil(a["c"])
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a["f"], Foo(id: "f", value: 13))
        }
        
        do { // set element with different existing id
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a[1] = Foo(id: "d", value: 13)
            XCTAssertEqual(a.count, 2)
            XCTAssertEqual(a[1], Foo(id: "d", value: 13))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertNil(a["b"])
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 13))
        }
        
        do { // set element with different existing id (old index < new index)
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a[3] = Foo(id: "b", value: 13)
            XCTAssertEqual(a.count, 2)
            XCTAssertEqual(a[1], Foo(id: "c", value: 5))
            XCTAssertEqual(a[2], Foo(id: "b", value: 13))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 13))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertNil(a["d"])
        }

        do { // change id
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a[2].id = "f"
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "f", value: 5))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertNil(a["c"])
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a["f"], Foo(id: "f", value: 5))
        }
    }
    
    func testSubscriptWithRange() {
        do { // Range
            let a: DictionarraySlice<Foo> = [
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
            let a: DictionarraySlice<Foo> = [
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
            let a: DictionarraySlice<Foo> = [
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
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a.append(Foo(id: "f", value: 13))
            XCTAssertEqual(a.count, 4)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
            XCTAssertEqual(a[4], Foo(id: "f", value: 13))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a["f"], Foo(id: "f", value: 13))
        }
        
        do { // element with existing id
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a.append(Foo(id: "c", value: 13))
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "d", value: 7))
            XCTAssertEqual(a[3], Foo(id: "c", value: 13))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 13))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
        }
    }
    
    func testInsert() {
        do {
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            a.insert(Foo(id: "f", value: 13), at: 2)
            XCTAssertEqual(a.count, 4)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "f", value: 13))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a[4], Foo(id: "d", value: 7))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a["f"], Foo(id: "f", value: 13))
        }
        
        do { // element with existing id
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
                Foo(id: "f", value: 13),
                Foo(id: "g", value: 17),
            ] as Dictionarray<Foo>)[1 ..< 6]
            a.insert(Foo(id: "e", value: 19), at: 2)
            XCTAssertEqual(a.count, 5)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "e", value: 19))
            XCTAssertEqual(a[3], Foo(id: "c", value: 5))
            XCTAssertEqual(a[4], Foo(id: "d", value: 7))
            XCTAssertEqual(a[5], Foo(id: "f", value: 13))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a["e"], Foo(id: "e", value: 19))
            XCTAssertEqual(a["f"], Foo(id: "f", value: 13))
        }
        
        do { // element with existing id (old index < new index)
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
                Foo(id: "f", value: 13),
                Foo(id: "g", value: 17),
            ] as Dictionarray<Foo>)[1 ..< 6]
            a.insert(Foo(id: "c", value: 19), at: 5)
            XCTAssertEqual(a.count, 5)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "d", value: 7))
            XCTAssertEqual(a[3], Foo(id: "e", value: 11))
            XCTAssertEqual(a[4], Foo(id: "c", value: 19))
            XCTAssertEqual(a[5], Foo(id: "f", value: 13))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 19))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
            XCTAssertEqual(a["e"], Foo(id: "e", value: 11))
            XCTAssertEqual(a["f"], Foo(id: "f", value: 13))
        }
    }
    
    func testPopLast() {
        var a: DictionarraySlice<Foo> = ([
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
            Foo(id: "d", value: 7),
            Foo(id: "e", value: 11),
        ] as Dictionarray<Foo>)[1 ..< 4]

        XCTAssertEqual(a.popLast(), Foo(id: "d", value: 7))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[1], Foo(id: "b", value: 3))
        XCTAssertEqual(a[2], Foo(id: "c", value: 5))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        XCTAssertNil(a["d"])
        
        XCTAssertEqual(a.popLast(), Foo(id: "c", value: 5))
        XCTAssertEqual(a.count, 1)
        XCTAssertEqual(a[1], Foo(id: "b", value: 3))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertNil(a["c"])
        
        XCTAssertEqual(a.popLast(), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 0)
        XCTAssertNil(a["b"])
        
        XCTAssertNil(a.popLast())
    }
    
    func testPopElement() {
        do {
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            XCTAssertEqual(a.popElement(for: "c"), Foo(id: "c", value: 5))
            XCTAssertEqual(a.count, 2)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "d", value: 7))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertNil(a["c"])
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
        }
        do {
            var a: DictionarraySlice<Foo> = ([
                Foo(id: "a", value: 2),
                Foo(id: "b", value: 3),
                Foo(id: "c", value: 5),
                Foo(id: "d", value: 7),
                Foo(id: "e", value: 11),
            ] as Dictionarray<Foo>)[1 ..< 4]
            XCTAssertNil(a.popElement(for: "f"))
            XCTAssertEqual(a.count, 3)
            XCTAssertEqual(a[1], Foo(id: "b", value: 3))
            XCTAssertEqual(a[2], Foo(id: "c", value: 5))
            XCTAssertEqual(a[3], Foo(id: "d", value: 7))
            XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
            XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
            XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
        }
    }
    
    func testRemoveLast() {
        var a: DictionarraySlice<Foo> = ([
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
            Foo(id: "d", value: 7),
            Foo(id: "e", value: 11),
        ] as Dictionarray<Foo>)[1 ..< 4]

        XCTAssertEqual(a.removeLast(), Foo(id: "d", value: 7))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[1], Foo(id: "b", value: 3))
        XCTAssertEqual(a[2], Foo(id: "c", value: 5))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertEqual(a["c"], Foo(id: "c", value: 5))
        XCTAssertNil(a["d"])
        
        XCTAssertEqual(a.removeLast(), Foo(id: "c", value: 5))
        XCTAssertEqual(a.count, 1)
        XCTAssertEqual(a[1], Foo(id: "b", value: 3))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertNil(a["c"])
        
        XCTAssertEqual(a.removeLast(), Foo(id: "b", value: 3))
        XCTAssertEqual(a.count, 0)
        XCTAssertNil(a["b"])
    }
    
    func testRemove() {
        var a: DictionarraySlice<Foo> = ([
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
            Foo(id: "d", value: 7),
            Foo(id: "e", value: 11),
        ] as Dictionarray<Foo>)[1 ..< 4]
        
        XCTAssertEqual(a.remove(at: 2), Foo(id: "c", value: 5))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[1], Foo(id: "b", value: 3))
        XCTAssertEqual(a[2], Foo(id: "d", value: 7))
    }
    
    func testRemoveElement() {
        var a: DictionarraySlice<Foo> = ([
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
            Foo(id: "d", value: 7),
            Foo(id: "e", value: 11),
        ] as Dictionarray<Foo>)[1 ..< 4]
        XCTAssertEqual(a.removeElement(for: "c"), Foo(id: "c", value: 5))
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(a[1], Foo(id: "b", value: 3))
        XCTAssertEqual(a[2], Foo(id: "d", value: 7))
        XCTAssertEqual(a["b"], Foo(id: "b", value: 3))
        XCTAssertNil(a["c"])
        XCTAssertEqual(a["d"], Foo(id: "d", value: 7))
    }
    
    func testIterator() {
        let a: DictionarraySlice<Foo> = ([
            Foo(id: "a", value: 2),
            Foo(id: "b", value: 3),
            Foo(id: "c", value: 5),
            Foo(id: "d", value: 7),
            Foo(id: "e", value: 11),
        ] as Dictionarray<Foo>)[1 ..< 4]
        var iterator = a.makeIterator()
        XCTAssertEqual(iterator.next(), Foo(id: "b", value: 3))
        XCTAssertEqual(iterator.next(), Foo(id: "c", value: 5))
        XCTAssertEqual(iterator.next(), Foo(id: "d", value: 7))
        XCTAssertNil(iterator.next())
    }
}
