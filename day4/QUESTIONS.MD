## 1. Is the heap memory saved when upgrading a canister? How much heap memory does a canister has?
**ANSWER**: No, heap memory is volatile. The Wasm heap is limited to 4 GB.

## 2. How much accounts can a unique Principal own?
**ANSWER**: There are a lot of Accounts which could be generated for a Principal, because a 32-bit unsigned integer has a maximum value of 4,294,967,295.

## 3. Can we safely upgrade a canister from interface A to interface B?

Interface A
```motoko
actor {
  public func greet(surname : Text, firstname : Text) : async Text {
    return "Hello" # firstname # surname # " !";
  };
}
```

Interface B
```motoko
actor {
  public func greet(firstname : Text) : async Text {
    return "Hello" # firstname # " !";
  };
}
```
**ANSWER**: Removing a parameter of a public function would change the Candid interface, but in this case there's no information being saved in the memory of the canister, so upgrading is safe because you won't lose anything.