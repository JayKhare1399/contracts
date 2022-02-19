// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Coin{
    address public minter;

    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    error InsufficientBalance(address sender, uint amount, uint insufficientAmount);

    constructor(){
        minter = msg.sender;
    }

    function mint(address receiver,uint amount) public {
        require(minter == msg.sender);
        balances[receiver] += amount;
    }

    function send (address receiver, uint amount) public{
        if(amount > balances[msg.sender]){
            revert InsufficientBalance({
                sender: msg.sender,
                amount:amount,
                insufficientAmount: amount - balances[msg.sender]
            });
        }
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender,receiver,amount);
    }

}
