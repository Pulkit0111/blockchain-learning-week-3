# Exercise 20: DApp Conceptualization
To conceptualize a decentralized banking platform using the "AdvancedToken" (an enhanced ERC-20 token), we'll need several smart contracts that work together to provide the required functionalities. Here's a HLD (High-Level-Design) of the primary smart contracts, their functions, and how they interact:

## Primary Smart Contracts:

### AdvancedToken (ERC-20 Token):
- An enhanced ERC-20 token contract, as previously defined, used as the platform's base currency.
- Manages user balances, locking, minting, and burning.
- Acts as collateral for lending and borrowing.

### DepositContract:
- A contract responsible for handling user deposits.
- Users can deposit traditional ERC-20 tokens into this contract.
- In return, they receive an equivalent amount of "AdvancedToken."
- Manages the conversion rate between traditional tokens and "AdvancedToken."

### LendingContract:
- Facilitates the lending of "AdvancedToken."
- Users can deposit "AdvancedToken" into this contract to earn interest.
- Provides an interest rate mechanism.
- Handles the distribution of interest to lenders.

### BorrowingContract:
- Enables users to borrow "AdvancedToken" against their holdings.
- Users must lock a certain amount of "AdvancedToken" as collateral.
- Manages borrowing limits and loan-to-value (LTV) ratios.
- Calculates and tracks interest on loans.

## Interaction Overview:

### Deposit Process:
- Users interact with the "DepositContract" to deposit traditional ERC-20 tokens.
- The "DepositContract" calculates the equivalent amount of "AdvancedToken" based on the current exchange rate.
- The "AdvancedToken" contract mints the corresponding amount of "AdvancedToken" and credits it to the user's balance.
- Users can now use the "AdvancedToken" for lending or borrowing.

### Lending Process:
- Users deposit "AdvancedToken" into the "LendingContract."
- The contract tracks the deposit, and users start earning interest.
- Interest is calculated based on the interest rate determined by the contract.
- Interest is periodically distributed to lenders' accounts.

### Borrowing Process:
- Users can request a loan by interacting with the "BorrowingContract."
- To borrow, users must lock a specified amount of "AdvancedToken" as collateral.
- The contract calculates the borrowing limit based on the LTV ratio and the locked collateral.
- Users receive the borrowed "AdvancedToken" in their account.
- The contract tracks the loan and calculates interest.
- Users can repay the loan with interest to unlock their collateral.









