public struct Dictionarray<Element>: MutableCollection, RandomAccessCollection where Element: Identifiable {
    public typealias Index = Int
    public typealias SubSequence = DictionarraySlice<Element>
    
    public private(set) var ids: [Element.ID]
    fileprivate private(set) var elements: [Element.ID: Element]
    
    public var startIndex: Int { 0 }
    public var endIndex: Int { ids.count }
    
    public init() {
        self.ids = []
        self.elements = [:]
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
        elements[element.id] = element
        ids.insert(element.id, at: index)
    }
    
    /// Complexity: *O(1)*
    @discardableResult
    public mutating func popLast() -> Element? {
        guard let id = ids.popLast() else { return nil }
        return elements.removeValue(forKey: id)!
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
}

extension DictionarraySlice {
    public init(_ dictionarray: Dictionarray<Element>) {
        self.init(ids: dictionarray.ids[...], elements: dictionarray.elements)
    }
}
