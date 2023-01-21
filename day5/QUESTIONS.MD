## 1. True or False: we can prevent the heap being erased during upgrades by using a stable heap.

**ANSWER**: False, you need to put the stable modifier on the var or data structure that can be made stable, but not on the whole heap.

## 2. A.call() -> B.call() -> C How much time (or rounds of consensus) do we need to wait for an answer?

**ANSWER**: If A, B, C are in different subnets, and C return message to B, then A, then we go through 2 rounds of 2 rounds of consensus.

## 3. Is possible to realize an intercanister call in query mode?

**ANSWER**: If we intercanister query call, and canister is on a different subnet is goes through consensus so it is an update call.