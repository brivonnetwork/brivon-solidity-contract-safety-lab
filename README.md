# Solidity Contract Safety Lab

A local-only Hardhat project for a video or workshop comparing two vault patterns:

- UnsafeLearningVault.sol intentionally updates user credit after an external call and is vulnerable to reentrancy.
- ChecksEffectsVault.sol clears credit before the external call and uses a simple reentrancy lock.

The vulnerable contract is included only to explain a bug. Do not deploy it, fund it, or connect it to a public network. The guarded example is a teaching sample, not an audited production vault.

## Compile the contracts locally

    npm install
    npm run compile

This project defines no external RPC network and includes no deployment command. The Solidity exercises remain local-only.

## Read the Brivon network catalogue

The optional Node.js example makes a read-only request to Brivon's network catalogue. It does not connect to either contract, submit a transaction, or deploy anything.

    cp .env.example .env
    npm run api:networks

`BRIVON_PUBLIC_APP_KEY` is a public application identifier sent in the `X-API-Key` header. It is not a private service credential. Keep `.env` local; never add a private API key to this project.
