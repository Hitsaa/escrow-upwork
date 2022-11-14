//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract EscrowContract {
    enum State { AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE }
    
    State public currState;
    
    address public developer;
    address payable public client;

    modifier onlyBuyer() {
        require(msg.sender == developer, "Only buyer can call this method");
        _;
    }


    constructor(address _developer, address payable _client) {
        developer = _developer;
        client = _client;
    }

    function deposit() onlyBuyer external payable {
        require(currState == State.AWAITING_PAYMENT, "Already paid");
        currState = State.AWAITING_DELIVERY;
    }

    function confirmDelivery() onlyBuyer external {
        require(currState == State.AWAITING_DELIVERY, "Cannot confirm delivery");
        console.log("%s", address(this));
        console.log("%s", address(this).balance);
        client.transfer(address(this).balance);
        currState = State.COMPLETE;
    }

    
}