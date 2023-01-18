# Questions

## 1. Who controls the ledger canister?

    
### Answer
    
**NNS**

## 2. What is the subnet of the canister with the id: mwrha-maaaa-aaaab-qabqq-cai? How much nodes are running this subnet?

### Answer

**Subnet Id: pae4o-o6dxf-xki7q-ezclx-znyd6-fnk6w-vkv5z-5lfwh-xym2i-otrrw-fqe. Nodes: 16**


## 3. I have a neuron with 1O ICPs locked with a dissolve delay of 4 years - my neuron has been locked for 2 years. What is my expected voting power?

### Answer 16.88
**Disolve Delay: 1.501 Maturity multiplier: 1.125 Voting power 10ICP * DisolveDelay * MM =  16.88**



## 4. What is the issue with the following code sample?

```motoko
actor {
  let n : Nat = 50;
  let t : Text = "Hello";

  public func convert_to_text(m : Nat) : async Text {
    Nat.toText(m);
  };
 
}
```
### Answer

**The import of Nat is missing, n, t are redudant**

## 5. What is wrong with the following code sample?

```motoko
actor {
  var languages : [var Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func show_languages(language : Text) : async [var Text] {
    return (languages);
  };
 
}
```
### Answer

**Can't make public an mutable array, the mutable array must be private then iq we cant to query it and make it public we must make it imutable probably tabulate function is an approach**

## 6. What is wrong with the following code sample?

```motoko
actor {
  var languages : [var Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func show_languages(language : Text) : async [var Text] {
    return (languages);
  };
 
}
```
### Answer

**The import of Array lib is missing, and append is deppricated better use a Buffer**
