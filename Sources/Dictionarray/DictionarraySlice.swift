public struct DictionarraySlice<Element>: MutableCollection, RandomAccessCollection where Element: Identifiable {
    public typealias Index = Int
    public typealias SubSequence = DictionarraySlice<Element>
    
    private var dictionarray: Dictionarray<Element>
    
    public let startIndex: Int
    public let endIndex: Int
    
    public init(_ dictionarray: Dictionarray<Element>) {
        self.init(dictionarray, bounds: dictionarray.indices)
    }
    
    internal init(_ dictionarray: Dictionarray<Element>, bounds: Range<Int>) {
        self.startIndex = bounds.startIndex
        self.endIndex = bounds.endIndex
        self.dictionarray = dictionarray
    }
    
    public subscript(index: Int) -> Element {
        get {
            dictionarray[index]
        }
        set {
            dictionarray[index] = newValue
        }
    }
}
