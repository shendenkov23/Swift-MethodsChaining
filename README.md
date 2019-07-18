# Swift-MethodsChaining
Chaining methods with swift generics

## Usage
```swift
some method ==> another method ==> some third methods (input) { result in
  switch result {
  case .success(let output):
      print("Chain success.)
  case .failure:
      print("Chain failure.")
  }
}
```
or
```swift
some method ==> { /*some closure, which call:*/ $1.success(inputDataForNextMethod) } ==> some third methods (input) { result in
  switch result {
  case .success(let output):
    print("Chain success.)
  case .failure:
    print("Chain failure.")
  }
}
```

Methods must have input parameter and completion with ChainOperationCompletion type.
