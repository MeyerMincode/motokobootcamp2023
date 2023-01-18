import Iter = "mo:base/Iter";
import Array = "mo:base/Array";
import Hash = "mo:base/Hash";
import HashMap = "mo:base/HashMap";
import Nat = "mo:base/Nat";

actor Chalenge2 {

  //1. Write a function average_array that takes an array of integers and returns the average value of the elements in the array.
  //average_array(array : [Int]) -> async Int. 

  public query func average_array(array : [Int]) : async Int {
    var sum : Int = 0;
    var counter: Int = 0;
    let arraySize = array.size();
    if(arraySize > 0){
      let iter = Iter.fromArray(array);
      for(i in iter){
        sum := i + sum;
        counter := counter + 1;
      };
      return sum/counter;
    } else return 0;
  };

  //2. Character count: Write a function that takes in a string and a character, and 
  //returns the number of occurrences of that character in the string.
  //count_character(t : Text, c : Char) -> async Nat

  public query func count_character(t : Text, c : Char) : async Nat {
    var counter : Nat = 0;
    for (character in t.chars()) {
      if( character == c ){
        counter += 1;
      };
    };
    return counter;
  };

  //3. Write a function factorial that takes a natural number n and returns the factorial of n.
  //factorial(n : Nat) ->  async Nat

  public query func factorial(n : Nat) : async Nat {
    if(n == 0){
      return 1;
    } else {
      var result : Nat = 1;
      let iter = Iter.range(1, n);
      for(i in iter){
        result := result * i;
      };
      return result;
    }
  };

  //4. Write a function number_of_words that takes a sentence and returns the number of words in the sentence.
  // number_of_words(t : Text) -> async Nat 

  public query func number_of_words(t : Text) : async Nat {
    var counter : Nat = 0;
    let c : Char = ' ';
    if(t.size() == 0) 
      return 0;
    for (character in t.chars()) {
      if( character == c ){
        counter += 1;
      };
    };
    return counter + 1;
  };

  //5. Write a function find_duplicates that takes an array of natural numbers and returns a new array containing all duplicate numbers. The order of the elements in the returned array should be the same as the order of the first occurrence in the input array.
  // find_duplicates(a : [Nat]) -> async [Nat]

 public func find_duplicates (array : [Nat]) : async [Nat] {

    let data: HashMap.HashMap<Nat, Nat> = HashMap.HashMap<Nat, Nat>(0, Nat.equal, Hash.hash);
    var result : [Nat] = [];
    let arrayIter = Iter.fromArray(array);

    for(i in arrayIter){
      var check = data.get(i);
      switch(check) {
        case(?found) {
          if(found == 1){
            result := Array.append<Nat>(result, [i]);
            data.put(i, 0);
          }
        };
        case(_) { 
          data.put(i, 1);
        };
      };
    };
    result;
  };

  //6. Write a function convert_to_binary that takes a natural number n and returns a string representing the binary representation of n.
  // convert_to_binary(n : Nat) -> async Text

  public query func convert_to_binary(n : Nat) : async Text {
    var result : Text = "";
    var rest : Nat = 0;
    var number : Nat = n;

    loop {
        rest := number % 2;
        number := (number-rest)/2;
        result := Nat.toText(rest) # result;

        if(number < 2) {
            if(number == 1) {
              result := "1" # result;
            };
              return result;
        };
    };
  };

};