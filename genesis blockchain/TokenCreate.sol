pragma solidity 0.4.25;

contract TokenCreate{
    
    mapping (address => uint256) private balances;
    uint256 private _totalSupply;
    address private admin;
    
    string public name;
    string public symbol;
    uint256 public decimals;
    
    constructor (uint256 totalSupply, string memory _name, string memory _symbol, uint256 _decimals) public  {
        admin = msg.sender;
        _totalSupply = totalSupply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        
        balances[admin] = totalSupply;
        
    }
    
    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }
    
    function tokensRemaining(address owner) public view returns (uint256){
        require(msg.sender == owner || msg.sender == admin);
        return balances[owner];
    }
    
 
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
   
    
    function giveTokens(address receiver, uint256 amount) public returns(bool success){
        require(balances[msg.sender] >= amount);
        
        balances[receiver] += amount;
        balances[msg.sender] -= amount;
        
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }
}