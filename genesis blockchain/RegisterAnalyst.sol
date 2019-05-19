pragma solidity 0.4.25;

contract RegisterAnalyst{
    mapping (address => uint256) private votes;
    mapping (address => bool) public analyst;
    address[] private totalAnalysts;
    address[] private voters;
    
    function registerAddress(address owner) public returns(bool success){
        analyst[owner] = false;
        votes[owner] = 0;
        totalAnalysts.push(owner);
        return true;
    } 
    
    function contains(address voter) private view returns(bool succsess){
        address[] memory arr = voters;
        for(uint i = 0; i < arr.length; i++){
            if(arr[i] == voter){
                return true;
            }
        }
        return false;
    }
    
    function voteAnalyst(address vote_party) public returns(bool success){
        require(msg.sender != vote_party);
        require(contains(msg.sender) == false);
        votes[vote_party] += 1;
        voters.push(msg.sender);
        return true;
    }
    
    function setAnalyst() public returns(bool success){
        address analystTop = totalAnalysts[0];
        uint256 max = votes[analystTop];
        for(uint256 i = 1; i < totalAnalysts.length; i++){
            address candidate = totalAnalysts[i];
            uint256 vote_val = votes[candidate];
            if(vote_val > max){
                analystTop = candidate;
                max = vote_val;
            }
        }
        analyst[analystTop] = true;
        return true;
    }
    
    function getAnalysts() public view returns(address[] memory){
        return totalAnalysts;
    }
}