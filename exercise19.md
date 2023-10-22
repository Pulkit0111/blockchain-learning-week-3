# Exercise 19: Debugging Scenario

## Identify potential reasons for this bug.
Potential reasons for this issue could be:

- The **_burnTokens_** function does not check whether the user's tokens are locked before allowing the burn operation.
- The locking mechanism in the **_ _lockedUntil_** mapping is not working as intended.

## 2. Write a unit test in Hardhat that simulates this error.
To simulate this error, we can write a unit test that attempts to burn tokens when they are locked.

```
it("Should not allow burning of locked tokens", async function () {
    await advancedToken.connect(owner).mintTokens(user1.address, 500);
    await advancedToken.connect(owner).lockTokens(user1.address, 7);

    // Attempt to burn tokens when they are locked
    await expect(advancedToken.connect(user1).burnTokens(200)).to.be.revertedWith("Your tokens are locked");
});
```

## 3. 3. Debug and fix the issue in the "AdvancedToken" contract.
The issue appears to be in the **_burnTokens_** function, which doesn't check whether the user's tokens are locked before allowing the burn operation. To fix this, we need to add a check to ensure that tokens cannot be burned while they are locked.
Here's the modified **_burnTokens_** function:

```
function burnTokens(uint256 amount) external {
    require(_lockedUntil[msg.sender] <= block.timestamp, "Your tokens are locked");
    require(_balances[msg.sender] >= amount, "Insufficient balance to burn");

    _balances[msg.sender] -= amount;
    _totalSupply -= amount;

    emit Transfer(msg.sender, address(0), amount);
    emit TokensBurned(msg.sender, amount);
}
```

## 4. 4. Document the debugging steps and the solution you implemented.
The debugging steps and the solution are documented as follows:

- Debugging Steps:
    - Identified that users could burn tokens even when tokens are locked.
    - Analyzed the **_burnTokens_** function and the locking mechanism.
    - Wrote a unit test to simulate the error and verify that tokens couldn't be burned while locked.
    - Observed that the issue was due to the missing check for locked tokens in the **_burnTokens_** function.

- Solutions:
    - Added a check for locked tokens at the beginning of the **_burnTokens_** function to prevent burning tokens when they are locked.
    - Modified the function to revert with an error message if the user's tokens are locked, ensuring that only unlocked tokens can be burned.




