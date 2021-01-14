public struct DictionarraySlice<Element>: MutableCollection, RandomAccessCollection where Element: Identifiable {
    public typealias Index = Int
    public typealias SubSequence = DictionarraySlice<Element>
    
    public private(set) var ids: ArraySlice<Element.ID>
    private var elements: [Element.ID: Element]

    public var startIndex: Int { ids.startIndex }
    public var endIndex: Int { ids.endIndex }
    
    internal init(ids: ArraySlice<Element.ID>, elements: [Element.ID: Element]) {
        self.ids = ids
        self.elements = elements
    }
    
    public init(_ elements: [Element]) {
        self.init(Dictionarray(elements))
    }
    
    public init<S>(_ elements: S) where S: Sequence, S.Element == Element {
        self.init(Dictionarray(elements))
    }
    
    /// Complexity: *O(1)*
    public subscript(index: Int) -> Element {
        get {
            elements[ids[index]]!
        }
        set {
            elements[ids[index]] = newValue
        }
    }
    
    /// Complexity: *O(1)*
    public subscript(id: Element.ID) -> Element? {
        elements[id]
    }
    
    /// Complexity: *O(1)*
    public subscript(bounds: Range<Int>) -> DictionarraySlice<Element> {
        DictionarraySlice<Element>(ids: ids[bounds], elements: elements)
    }
    
    /// Complexity: *O(1)*
    public mutating func append(_ element: Element) {
        if elements.keys.contains(element.id) {
            ids.remove(at: ids.firstIndex(of: element.id)!)
        }
        refreshElementsIfNeeded()
        elements[element.id] = element
        ids.append(element.id)
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    public mutating func insert(_ element: Element, at index: Int) {
        var index: Int = index
        if elements.keys.contains(element.id) {
            let currentIndex: Int = ids.firstIndex(of: element.id)!
            ids.remove(at: currentIndex)
            if currentIndex < index {
                index -= 1
            }
        }
        refreshElementsIfNeeded()
        elements[element.id] = element
        ids.insert(element.id, at: index)
    }
    
    private mutating func refreshElementsIfNeeded() {
        guard elements.count == elements.capacity else { return }
        var newElements: [Element.ID: Element] = [:]
        for id in ids {
            newElements[id] = elements[id]!
        }
        elements = newElements
    }
    
    /// Complexity: *O(1)*
    public mutating func popLast() -> Element? {
        guard let id = ids.popLast() else { return nil }
        return elements.removeValue(forKey: id)!
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    public mutating func popElement(for id: Element.ID) -> Element? {
        guard let index = ids.firstIndex(of: id) else { return nil }
        return remove(at: index)
    }
    
    /// Complexity: *O(1)*
    @discardableResult
    public mutating func removeLast() -> Element {
        let id = ids.removeLast()
        return elements.removeValue(forKey: id)!
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        let id = ids.remove(at: index)
        return elements.removeValue(forKey: id)!
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    @discardableResult
    public mutating func removeElement(for id: Element.ID) -> Element {
        let index = ids.firstIndex(of: id)!
        return remove(at: index)
    }
}


extension DictionarraySlice: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

extension DictionarraySlice: CustomStringConvertible {
    public var description: String {
        Array(self).description
    }
}

extension DictionarraySlice: Equatable where Element: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        guard lhs.count == rhs.count else { return false }
        for (l, r) in zip(lhs, rhs) {
            guard l == r else { return false }
        }
        return true
    }
}
