pragma solidity ^0.4.6;

contract samplecontract {

    uint initialSupply = uint(100);
    uint transactionCost = 1;
    uint transactionCount = 0;

    address owner;

    mapping (address => uint) private balance;
    mapping (address => bool) moneySpent;

    function question1() public {
        balance[msg.sender] = initialSupply;
        owner = msg.sender;
        moneySpent[msg.sender] = false;
    }

    function tax() private returns (bool){
        if(balance[msg.sender] - 1 < 0)
            return false;
        balance[msg.sender] -= 1;
        return true;
    }

    function checkEligiblity(uint _money) private returns (bool) {
        if((balance[msg.sender] - _money < 0) || (tax() == false) || (_money < 0) || (transactionCount > 0))
            return false;
        // require(false == true);
        moneySpent[msg.sender] = true;
        transactionCount++;
        return true;
    }   

    function transfer(address _to, uint _money) public returns (bool) {
        require(checkEligiblity(_money) == true);
        balance[msg.sender] -= _money;
        balance[_to] += _money;
        return true;
    }

    function myBalance() public view returns (uint) {
        return balance[msg.sender];
    }

    function spent() public view returns (bool){
        return moneySpent[msg.sender];
    }

    function checkResult() public view returns (bool) {
        if ( balance[msg.sender] == initialSupply && moneySpent[msg.sender] == true)
            return true;
        else
            return false;
    }

}
