## Usage

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Deploy

Each network has a specific deployment script. For example, to deploy to the Sepolia network (equivalent to test network), run the following command:

```shell
forge script --rpc-url $OPTIMISM_RPC_URL --broadcast --verify -vvvv script/DeployProposalsResolver.s.sol:DeployProposalsResolverScript
forge script --rpc-url $OPTIMISM_RPC_URL --broadcast --verify -vvvv script/CreateVotesEASSchema.s.sol:CreateVotesEASSchemaScript
```

You need to replace `SEPOLIA_RPC_URL` with the RPC url to which you want to deploy the contract.
Also, you'll need to set `PRIVATE_KEY` environment variable to the private key of the account that will deploy the contract.
