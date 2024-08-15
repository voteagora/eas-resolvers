## Optimism Identity protocol

Optimism identity protocol is powered by Ethereum Attestation Service (EAS). Current version of the protocol is centralized and requires a trusted entity to be the attester. This repository contains resolver smart contracts that will eventualy be used to manage permisisons and take over the need to trust a single entity.

<table>
<tr>
<th>Network</th>
<th>Entity resolver</th>
<th>Entity schema</th>
<th>Organization Metadata resolver</th>
<th>Organization Metadata schema</th>
</tr>
<tr>
<td>Optimism Mainnet (Production)</td>
<td><code>N/A</code></td>
<td><code>N/A</code></td>
<td><code>N/A</code></td>
<td><code>N/A</code></td>
</tr>
<tr>
<td>Sepolia (Test)</td>
<td><code>0x69dAbd289CF35263b3940B7a0b495B10f9F2e254</code></td>
<td><code>0x4222d050383fadf18ce0ccd8f37a569a655c05e07d6bdc638c1472da01842ef8</code></td>
<td><code>0xf9F9CF7021bA416F7D65D07b484Bd71396cBfDd8</code></td>
<td><code>0x9039564787fb32c75c224c977ba9f4c4af53fa0a6e917cb6c0eb6f4a6eaf2055</code></td>

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
