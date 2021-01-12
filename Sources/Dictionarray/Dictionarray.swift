public struct Dictionarray<Element>: MutableCollection, RandomAccessCollection where Element: Identifiable {
    public typealias Index = Int
    public typealias SubSequence = DictionarraySlice<Element>
    
    private var ids: [Element.ID]
    private var elements: [Element.ID: (index: Int, element: Element)]
    
    public var startIndex: Int { 0 }
    public var endIndex: Int { ids.count }
    
    public init() {
        self.ids = []
        self.elements = [:]
    }

    /// Complexity: *O(1)*
    public subscript(index: Int) -> Element {
        get {
            elements[ids[index]]!.element
        }
        set {
            elements[ids[index]] = (index, newValue)
        }
    }
    
    /// Complexity: *O(1)*
    public subscript(id: Element.ID) -> Element? {
        elements[id]?.element
    }
    
    /// Complexity: *O(1)*
    public subscript(bounds: Range<Int>) -> DictionarraySlice<Element> {
        DictionarraySlice<Element>(self, bounds: bounds)
    }
    
    /// Adds a new element at the end of the dictionarray.
    /// If the dictionarray contains an element whose `id` is equal to the given `element`'s,
    /// it returns the contained element instead of appending the given `element`.
    ///
    /// Complexity: *O(1)*
    ///
    /// - Parameters:
    ///     - element: The element to append to the dictionarray.
    /// - Returns: An contained element and its index, or `nil` when the given `element` is appended.
    @discardableResult
    public mutating func append(_ element: Element) -> (index: Int, element: Element)? {
        if let (index0, element0) = elements[element.id] {
            return (index0, element0)
        } else {
            elements[element.id] = (count, element)
            ids.append(element.id)
            return nil
        }
    }
    
    /// Adds a new element at the end of the dictionarray.
    /// If the dictionarray contains an element whose `id` is equal to the given `element`'s,
    /// the contained element is replaced with the given `element` instead of appending.
    ///
    /// Complexity: *O(1)*
    ///
    /// - Parameters:
    ///     - element: The element to append to the dictionarray.
    /// - Returns: An contained element and its index, or `nil` when the given `element` is appended.
    @discardableResult
    public mutating func appendOrReplace(_ element: Element) -> (index: Int, element: Element)? {
        if let (index0, element0) = elements[element.id] {
            elements[element.id] = (index0, element)
            return (index0, element0)
        } else {
            elements[element.id] = (count, element)
            ids.append(element.id)
            return nil
        }
    }
    
    /// Complexity: *O(n)*, where *n* is the length of the dictionarray.
    @discardableResult
    public mutating func insert(_ element: Element, at index: Int) -> (index: Int, element: Element)? {
        if let (index0, element0) = elements[element.id] {
            return (index0, element0)
        } else {
            elements[element.id] = (index, element)
            for id in ids[index...] {
                elements[id]!.index += 1
            }
            ids.insert(element.id, at: index)
            return nil
        }
    }
    
    /// Complexity: *O(1)*
    @discardableResult
    public mutating func popLast() -> Element? {
        guard let id = ids.popLast() else { return nil }
        return elements.removeValue(forKey: id)!.element
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
        for id in ids[index...] {
            elements[id]!.index -= 1
        }
        return elements.removeValue(forKey: id)!.element
    }
}
