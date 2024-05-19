# Plugins

Please note, these plugins are in a pre-alpha state and are not ready for production use. In their current state, the plugins are meant for testing and experimentation.

# Getting Started

1. `cd packages/plugins`
2. Run `yarn submodules` to initialize git submodules
3. Run `yarn` to install hardhat dependencies
4. Run `forge install` to install foundry dependencies

## (optional) ZKP Plugins

Link `zkp` directory for ZKP based plugins. Make sure you have [circom installed](../zkp/README.md).
```bash
cd ../zkp
yarn
yarn link
cd ../plugins
yarn link '@getwax/circuits'
```

## Build & generate Typechain definitions

```bash
yarn build
```

## Forge tests

```bash
forge test
```

## Hardhat tests

To run the hardhat tests, you'll need to run a node and a bundler as some of them are integration tests:

1. Create an `.env` file with the values from `.env.example`:

```bash
cp .env.example .env
```

2. Start a geth node, fund accounts, deploy Safe contracts, and start a bundler:

```bash
# Note: This uses geth. There is also start-hardhat.sh for using hardhat. See
# docs inside each script for more information.
./script/start.sh
```

3. Run the plugin tests:

```bash
yarn hardhat test
```


# For zkSync

## Build

Install foundry-zksync
forge build

## Missing libraries

forge create --deploy-missing-libraries --private-key {YOUR_PRIVATE_KEY} --rpc-url https://sepolia.era.zksync.dev --chain 300 --zksync


## Deployment

Fill .env with the values

```
source .env
forge script script/DeploySafeZkEmailRecoveryPlugin.s.sol:Deploy --zksync --rpc-url $SEPOLIA_RPC_URL --broadcast -vvvv
```

```
SafeZkEmailRecoveryPlugin deployed at: 0xa87f3EeDe036cd74B4Ef7F754CD11c6A8A0caF6E
```
