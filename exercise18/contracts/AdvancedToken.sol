// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedToken {
    string public name; 
    string public symbol; 
    uint8 public decimals; 
    uint256 private _totalSupply;
    uint256 private _maxSupply;
    address private _owner;

    // Balances of token holders
    mapping(address => uint256) private _balances;
    // Allowances for token transfers on behalf of token holders
    mapping(address => mapping(address => uint256)) private _allowances;
    // Timestamp when tokens are locked for a user
    mapping(address => uint256) private _lockedUntil;

    // Events to track token transfers, approvals, locking, minting, and burning
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event TokensLocked(address indexed user, uint256 unlockTimestamp);
    event TokensUnlocked(address indexed user);
    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 initialSupply, uint256 maxSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        require(maxSupply >= initialSupply, "Max supply must be greater than or equal to initial supply");
        _maxSupply = maxSupply;
        _totalSupply = initialSupply * 10 ** uint256(decimals);
        _balances[msg.sender] = _totalSupply;
        _owner = msg.sender;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    // Get the total supply of tokens
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // Get the balance of tokens for an account
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    // Transfer tokens to a specified address
    function transfer(address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid Address");
        require(_lockedUntil[msg.sender] <= block.timestamp, "Your tokens are locked");
        require(_balances[msg.sender] >= value, "Insufficient balance");
        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // Approve another address to spend tokens on your behalf
    function approve(address spender, uint256 value) public returns (bool) {
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // Transfer tokens from one address to another on behalf of the sender
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid Address");
        require(_lockedUntil[from] <= block.timestamp, "Sender's tokens are locked");
        require(_balances[from] >= value, "Insufficient balance");
        require(_allowances[from][msg.sender] >= value, "Allowance exceeded");
        _balances[from] -= value;
        _balances[to] += value;
        _allowances[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    // Lock tokens for a user for a specified duration (only callable by the owner)
    function lockTokens(address user, uint256 durationInDays) external {
        require(msg.sender == _owner, "Only the owner can lock tokens");
        require(durationInDays > 0, "Duration must be greater than 0");
        _lockedUntil[user] = block.timestamp + (durationInDays * 1 days);
        emit TokensLocked(user, _lockedUntil[user]);
    }

    // Unlock tokens for a user (only callable by the owner)
    function unlockTokens(address user) external {
        require(msg.sender == _owner, "Only the owner can unlock tokens");
        require(_lockedUntil[user] > 0, "User's tokens are not locked");
        delete _lockedUntil[user];
        emit TokensUnlocked(user);
    }

    // Mint new tokens to an address (only callable by the owner)
    function mintTokens(address to, uint256 amount) external {
        require(msg.sender == _owner, "Only the owner can mint tokens");
        require(_totalSupply + amount <= _maxSupply, "Max supply exceeded");
        _totalSupply += amount;
        _balances[to] += amount;
        emit Transfer(address(0), to, amount);
        emit TokensMinted(to, amount);
    }

    // Burn tokens from the sender's account
    function burnTokens(uint256 amount) external {
        require(_balances[msg.sender] >= amount, "Insufficient balance to burn");
        _balances[msg.sender] -= amount;
        _totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
        emit TokensBurned(msg.sender, amount);
    }
}
