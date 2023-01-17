# Questions

## 1. How much is the current memory capacity of a canister?
    
### Answer
    
**The stable memory of a canister is 8 GB (used to be 4 GB). The Wasm heap is still limited to 4 GB.**

## 2. What is the issue with the following code sample?

```motoko
actor {
  let counter : Nat = 0;
  public func increment_counter() : async () {
    counter := counter + 1;
  };
}
```
### Answer

**Counter is declared with let but we re-asign it a new value. We should declare counter with var.**


## 3. What is the issue with the following code sample?

```motoko

actor {
  var message : Text = 0;

  public query func change_message(new_message : Text) : async () {
    message := new_message;
    return;
  };
  
  public query func see_message() : async Text {
    return(message);
  };
}
```
### Answer
**The message variable is declared of type Text but is asigned the value 0 of type Nat(number)**



## 4. False or True: we can remove the keyword async for return argument of a query function since queries are faster to answer.

### Answer
**False. "In Motoko, an expression occurs in an asynchronous context if it appears in the body of an async expression, which may be the body of a (shared or local) function or a stand-alone expression. The only exception are query functions, whose body is not considered to open an asynchronous context."(internet computer documentation)**
