import Array "mo:base/Array";
import Int "mo:base/Int";
import Buffer "mo:base/Buffer";

//1. In your file called utils.mo: create a function called second_maximum that takes an array [Int] of integers and returns the second largest number in the array.
//second_maximum(array : [Int]) ->  Int;

actor{
  public query func second_max(array : [Int]) : async Int {

    let arraySize = array.size();

    if(arraySize == 0) return 0;
    if(arraySize == 1) return array[0];
    if(arraySize >= 2){
      let sortArray = Array.sort(array, Int.compare);
      let max = sortArray[arraySize - 1];
      let filteredArray = Array.filter<Int>(sortArray, func x = x != max);
      return filteredArray[filteredArray.size() -1 ];
    };
    0;
  };

  //2.In your file called utils.mo: create a function called remove_even that takes an array [Nat] and returns a new array with only the odd numbers from the original array.
  //remove_even(array : [Nat]) -> [Nat];

  public query func remove_even(array : [Nat]) : async [Nat]{
    Array.filter<Nat>(array, func x = x % 2 == 1);
  };

  //3. In your file called utils.mo: write a function drop that takes 2 parameters: an array [T] and a Nat n. This function will drop the n first elements of the array and returns the remainder.
  //drop<T> : (xs : [T], n : Nat) -> [T]

  func drop<T>(array : [T], n : Nat) : [T]{
    if(n >= 1){
      let buf = Buffer.fromArray<T>(array);
      buf.filterEntries(func(i, x) = i > n-1);
      let backToArray = Buffer.toArray(buf);
      return backToArray;
    } else return array;
  };
  public query func test_drop(array : [Nat], n : Nat) : async [Nat]{
    drop<Nat>(array, n);
  };
}