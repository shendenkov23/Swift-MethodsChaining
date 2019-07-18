# Swift-MethodsChaining
Chaining methods with swift generics

## Usage
```swift
some method ==> another method ==> some third methods
```
or
```swift
some method ==> { /*some closure, which call:*/ $1.success(inputDataForNextMethod) } ==> some third methods etc.
```

Methods must have input parameter and completion with ChainOperationCompletion type.
