// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;
import './ERC20Contract.sol';
import './ClientDeveloperContract.sol';
import './EscrowContract.sol';
import "hardhat/console.sol";

contract ClientContract {
    enum State { AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE }
    ClientDeveloperContract cc;
    mapping(address => uint256) balances;
    ERC20Contract erctoken = new ERC20Contract();

    constructor() {
        
    }

   function balanceOf(address tokenOwner) public view returns (uint256) {
        return balances[tokenOwner];
    }

    function setTokens(uint256 tokens) public {
        balances[msg.sender] += tokens;
    }

    function addToWallet(uint256 tokens) public {
        erctoken.transfer(address(this), tokens);
        balances[address(this)] = tokens;
        console.log("%s %s", address(this), msg.sender);
    }

    function createProject() public {
        cc = new ClientDeveloperContract();
        cc.setClient(msg.sender);
    }

    function approveMilestone(string milestone) public {
        
    }

}