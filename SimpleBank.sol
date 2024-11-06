// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    // Mapping to keep track of balances for each account (address)
    mapping(address => uint) private balances;

    // Event to log deposits
    event Deposit(address indexed account, uint amount);

    // Event to log withdrawals
    event Withdrawal(address indexed account, uint amount);

    // Deposit function - allows a user to deposit Ether into their account
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw function - allows a user to withdraw Ether from their account
    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(_amount > 0, "Withdrawal amount must be greater than 0");

        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

        emit Withdrawal(msg.sender, _amount);
    }

    // Show balance function - returns the balance of the caller
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}
