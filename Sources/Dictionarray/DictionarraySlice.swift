public struct DictionarraySlice<Element>: MutableCollection, RandomAccessCollection where Element: Identifiable {
    public typealias Index = Int
    public typealias SubSequence = DictionarraySlice<Element>
    
    public private(set) var ids: ArraySlice<Element.ID>
    private var elements: [Element.ID: (index: Int, element: Element)]

    public var startIndex: Int { ids.startIndex }
    public var endIndex: Int { ids.endIndex }
    
    internal init(ids: ArraySlice<Element.ID>, elements: [Element.ID: (index: Int, element: Element)]) {
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
            elements[ids[index]]!.element
        }
        set {
            precondition(indices.contains(index))
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
        guard let (index, element) = elements[id] else { return nil }
        return indices.contains(index) ? element : nil
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
        guard let index = elements[id]?.index else { return false }
        return indices.contains(index)
    }

    private mutating func refreshElementsIfNeeded() {
        guard elements.count == elements.capacity else { return }
        var newElements: [Element.ID: (index: Int, element: Element)] = [:]
        for id in ids {
            newElements[id] = elements[id]!
        }
        elements = newElements
    }
    
    /// Complexity: *O(1)*
    public mutating func append(_ element: Element) {
        if let oldIndex = elements[element.id]?.index {
            ids.remove(at: oldIndex)
        }
        refreshElementsIfNeeded()
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
        refreshElementsIfNeeded()
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
