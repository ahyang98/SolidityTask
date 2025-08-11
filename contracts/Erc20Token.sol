//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// balanceOf：查询账户余额。
// transfer：转账。
// approve 和 transferFrom：授权和代扣转账。
// 使用 event 记录转账和授权操作。
// 提供 mint 函数，允许合约所有者增发代币。
// 提示：
// 使用 mapping 存储账户余额和授权信息。
// 使用 event 定义 Transfer 和 Approval 事件。
// 部署到sepolia 测试网，导入到自己的钱包

contract Erc20Token {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    address public owner;
    string public tokenName;
    string public tokenSymbol;
    constructor(string memory name, string memory symbol, uint256 initialSupply) {
        owner = msg.sender;
        _totalSupply = initialSupply;
        _balances[msg.sender] = initialSupply;
        tokenName = name;
        tokenSymbol = symbol;
    }

    function balanceOf()  public view returns (uint256) {
         return _balances[msg.sender];
    }

    function transfer(address addr, uint256 value) public returns (bool) {    
        require(_balances[msg.sender] >= value, "Insufficient balance");            
        _balances[msg.sender] -= value;
        _balances[addr] += value;
        emit Transfer(msg.sender, addr, value);
        return true; 
    }

    function approve(address spender, uint256 value) public returns (bool) {        
        require(spender != address(0), "spender should not be zero address");
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value); 
        return true;
    }

    function transferFrom(address sender, uint256 amount) public returns (bool) {
        require(_balances[sender] >= amount, "Insufficient balance");
        require(_allowances[sender][msg.sender] >= amount, "Allowance exceeded");
        _balances[sender] -= amount;
        _balances[msg.sender] += amount;
        _allowances[sender][msg.sender] -= amount;
        emit Transfer(sender, msg.sender, amount);
        return true;
    }

    function mint(uint256 amount) public {
        require(msg.sender == owner, "Only owner can mint");
        _totalSupply += amount;
        _balances[owner] += amount;
        emit Transfer(address(0), owner, amount);
    }
}