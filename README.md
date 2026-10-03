# Solidity Contract Safety Lab

A local-only Hardhat project for a video or workshop comparing two vault patterns:

- UnsafeLearningVault.sol intentionally updates user credit after an external call and is vulnerable to reentrancy.
- ChecksEffectsVault.sol clears credit before the external call and uses a simple reentrancy lock.

The vulnerable contract is included only to explain a bug. Do not deploy it, fund it, or connect it to a public network. The guarded example is a teaching sample, not an audited production vault.

## Run

    npm install
    npm run compile

This project defines no external RPC network and includes no deployment command. It is isolated from the Brivon application and API.
