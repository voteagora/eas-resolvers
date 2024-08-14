## Optimism Identity protocol

Optimism identity protocol is powered by Ethereum Attestation Service (EAS). Current version of the protocol is centralized and requires a trusted entity to be the attester. This repository contains resolver smart contracts that will eventualy be used to manage permisisons and take over the need to trust a single entity.

<table>
<tr>
<th>Network</th>
<th>Entities resolver</th>
<th>Entities schama</th>
</tr>
<tr>
<td>Optimism Mainnet (Production)</td>
<td><code>N/A</code></td>
<td><code>N/A</code></td>
</tr>
<tr>
<td>Sepolia (Test)</td>
<td><code>0x0a499d974ED539103a671996Dd4Bc02ef057fed7</code></td>
<td><code>0x8c7caec2099387742528885f57e0bfab6f76bdbc898ef2e5a10e5b2c664e0966</code></td>

</tr>
</table>

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
forge script --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv script/DeployEntitiesResolver.s.sol:DeployEntitiesResolverScript
```

You need to replace `SEPOLIA_RPC_URL` with the RPC url to which you want to deploy the contract.
Also, you'll need to set `PRIVATE_KEY` environment variable to the private key of the account that will deploy the contract.
