# Dictionarray

`Dictionarray` is a data type which has both characteristics of `Array` and `Dictionary`.

```swift
var users: Dictionarray<User> = [
    User(id: "aaa", name: "Chris"),
    User(id: "bbb", name: "Rob"),
    User(id: "ccc", name: "Graydon"),
]

// All following operations run in O(1).
print(users[0].name)         // Chris
print(users[id: "aaa"].name) // Chris

users.append(User(id: "ddd", name: "Martin"))
```

Elements of `Dictionarray`s must be conform to `Identifiable`. `id`s of elements can be used as keys to get elements from `Dictionarray`s through `subscript(id:)`.

## With SwiftUI

`Dictionarray` is useful when used combined with SwiftUI's `Binding` and `ForEach`.

```swift
struct UsersView: View {
    @Binding var users: Dictionarray<User>

    var body: some View {
        LazyVStack {
            ForEach(users.ids, id: \.self) { id in
                UserView($users[id: id])
            }
        }
    }
}
```

## License

MIT
