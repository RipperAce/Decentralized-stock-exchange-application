pragma solidity 0.4.25;

import "./TokenCreate.sol";
import "./RegisterAnalyst.sol";

contract ShareExchange{
    address admin;
    TokenCreate public tokenContract;
    RegisterAnalyst public registerAnalyst;
    uint256 public tokenPrice;
    uint256 public tokensSold;
    uint numberOfTokens;
    bool transaction = false;
    address buyer;

    event Sell(address _buyer, uint256 _amount);

    constructor (RegisterAnalyst _registerAnalyst, TokenCreate _tokenContract, uint256 _tokenPrice) payable {
        admin = msg.sender;
        tokenContract = _tokenContract;
        registerAnalyst = _registerAnalyst;
        tokenPrice = _tokenPrice * 1 ether;
    }

    function increasePrice(uint256 val) public returns(bool success){
        require(registerAnalyst.analyst(msg.sender) == true);
        require(msg.sender != admin);
        
        tokenPrice += val;
        return true;
    }
    
    function decreasePrice(uint256 val) public returns(bool success){
        require(registerAnalyst.analyst(msg.sender) == true);
        require(msg.sender != admin);
        
        tokenPrice -= val;
        return true;
    }
    
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
        return x * y;
    }
    
    function getBalance(address msg_sender) public view returns(uint256){
        return msg_sender.balance;
    }
    
    function() payable{
        admin.transfer(address(this).balance);
    }
    
    function getNumberOfTokens(uint256 _numberOfTokens) public{
        numberOfTokens = _numberOfTokens;
        buyer = msg.sender;
        
    }
    
    function transferTokensToBuyer() public {
        tokenContract.giveTokens(buyer, numberOfTokens);
        transaction = true;
    }
    
    function buyTokens() payable returns(bool) {
        require(msg.value == multiply(numberOfTokens, tokenPrice));
        require(transaction == true);
        tokensSold += numberOfTokens;
        
        emit Sell(buyer, numberOfTokens);
        transaction = false;
        
        return true;
    }
}