// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

/// @notice Intentionally vulnerable teaching sample. Never deploy this contract.
contract UnsafeLearningVault {
    mapping(address account => uint256 amount) public credit;

    receive() external payable {
        credit[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amount = credit[msg.sender];
        require(amount != 0, "Nothing to withdraw");

        // Unsafe order: the external call happens before the credit is cleared.
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "Transfer failed");
        credit[msg.sender] = 0;
    }
}
