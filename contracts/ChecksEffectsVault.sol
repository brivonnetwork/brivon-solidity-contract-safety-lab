// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

/// @notice Teaching example that clears user credit before its external call.
contract ChecksEffectsVault {
    error NothingToWithdraw();
    error TransferFailed();
    error ReentrantCall();

    mapping(address account => uint256 amount) public credit;
    uint256 private _lock = 1;

    receive() external payable {
        credit[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
        uint256 amount = credit[msg.sender];
        if (amount == 0) revert NothingToWithdraw();

        // Effects precede interaction, so a callback cannot withdraw the same credit again.
        credit[msg.sender] = 0;
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        if (!sent) revert TransferFailed();
    }

    modifier nonReentrant() {
        if (_lock != 1) revert ReentrantCall();
        _lock = 2;
        _;
        _lock = 1;
    }
}
