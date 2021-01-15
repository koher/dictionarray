public struct Dictionarray<Element>: MutableCollection, RandomAccessCollection where Element: Identifiable {
    public typealias Index = Int
    public typealias SubSequence = DictionarraySlice<Element>
    
    public private(set) var ids: [Element.ID]
    fileprivate private(set) var elements: [Element.ID: (index: Int, element: Element)]
    
    public var startIndex: Int { 0 }
    public var endIndex: Int { ids.count }
    
    public init() {
        self.ids = []
        self.elements = [:]
    }
    
    public init(_ elements: [Element]) {
        self.ids = elements.map(\.id)
        self.elements = .init(
            uniqueKeysWithValues: elements.enumerated().map { i, e in (e.id, (i, e)) }
        )
    }
    
    public init<S>(_ elements: S) where S: Sequence, S.Element == Element {
        self.init(Array(elements))
    }

    /// Complexity: *O(1)* for `get`, *O(1)* or *O(n)* for `set` where *n* is the length of the dictionarray.
    public subscript(index: Int) -> Element {
        get {
            elements[ids[index]]!.element
        }
        set {
            if self[index].id == newValue.id {
                elements[newValue.id] = (index, newValue)
            } else if let oldIndex = elements[newValue.id]?.index {
                var index = index
                let oldID = ids[index]
                if oldIndex < index {
                    index -= 1
                }
                ids.remove(at: oldIndex)
                elements[newValue.id] = (index, newValue)
                ids[index] = newValue.id
                elements.removeValue(forKey: oldID)
            } else {
                let oldID = ids[index]
                elements[newValue.id] = (index, newValue)
                ids[index] = newValue.id
                elements.removeValue(forKey: oldID)
            }
        }
    }
    
    /// Complexity: *O(1)*
    public subscript(id: Element.ID) -> Element? {
        elements[id]?.element
    }
    
    /// Complexity: *O(1)*
    public subscript(bounds: Range<Int>) -> DictionarraySlice<Element> {
        DictionarraySlice<Element>(ids: ids[bounds], elements: elements)
    }

    /// Complexity: *O(1)*
    public subscript<R>(bounds: R) -> DictionarraySlice<Element> where R: RangeExpression, R.Bound == Int {
        DictionarraySlice<Element>(ids: ids[bounds], elements: elements)
    }
    
    /// Complexity: *O(1)*
    public subscript(bounds: UnboundedRange) -> DictionarraySlice<Element> {
        DictionarraySlice<Element>(ids: ids[bounds], elements: elements)
    }
    
    /// Complexity: *O(1)*
    public func containsElement(for id: Element.ID) -> Bool {
        elements.keys.contains(id)
    }

    /// Complexity: *O(1)*
    public mutating func append(_ element: Element) {
        if let oldIndex = elements[element.id]?.index {
            ids.remove(at: oldIndex)
        }
        elements[element.id] = (ids.count, element)
        ids.append(element.id)
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    public mutating func insert(_ element: Element, at index: Int) {
        var index: Int = index
        if let oldIndex = elements[element.id]?.index {
            ids.remove(at: oldIndex)
            if oldIndex < index {
                index -= 1
            }
        }
        elements[element.id] = (index, element)
        ids.insert(element.id, at: index)
    }
    
    /// Complexity: *O(1)*
    public mutating func popLast() -> Element? {
        guard let id = ids.popLast() else { return nil }
        return elements.removeValue(forKey: id)!.element
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    public mutating func popElement(for id: Element.ID) -> Element? {
        guard let index = elements[id]?.index else { return nil }
        return remove(at: index)
    }
    
    /// Complexity: *O(1)*
    @discardableResult
    public mutating func removeLast() -> Element {
        let id = ids.removeLast()
        return elements.removeValue(forKey: id)!.element
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        let id = ids.remove(at: index)
        return elements.removeValue(forKey: id)!.element
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    @discardableResult
    public mutating func removeElement(for id: Element.ID) -> Element {
        let index = elements[id]!.index
        return remove(at: index)
    }
}

extension Dictionarray: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

extension Dictionarray: CustomStringConvertible {
    public var description: String {
        Array(self).description
    }
}

extension Dictionarray: Equatable where Element: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        guard lhs.count == rhs.count else { return false }
        for (l, r) in zip(lhs, rhs) {
            guard l == r else { return false }
        }
        return true
    }
}

extension DictionarraySlice {
    public init(_ dictionarray: Dictionarray<Element>) {
        self.init(ids: dictionarray.ids[...], elements: dictionarray.elements)
    }
}
