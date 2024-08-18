## Optimism Identity protocol

Optimism identity protocol is powered by Ethereum Attestation Service (EAS). Current version of the protocol is centralized and requires a trusted entity to be the attester. This repository contains resolver smart contracts that will eventualy be used to manage permisisons and take over the need to trust a single entity.

<table>
<tr>
<th>Network</th>
<th>Entity resolver</th>
<th>Entity Resolver proxy admin</th>
<th>Entity schema</th>
<th>Organization Metadata resolver</th>
<th>Organization Metadata resolver proxy admin</th>
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
<td><code>0xfA93d7364fCe1056EAab591DF1C0b01aBCa37461</code></td>
<td><code>0xaDAAca76f4825F1b7241E05A0657Daec4EcFfe39</code></td>
<td><code>0x5eefb359bc596699202474fd99e92172d1b788aa34280f385c498875d1bfb424</code></td>
<td><code>0x0287cf4e225B02D42D90d626C6233cf7F0c7103d</code></td>
<td><code>0xDdD8B952aE933584F3caEBfFCDB2D5Fffdf86235</code></td>
<td><code>0x9c181f1e683fd2d79287d0b4fe1832f571fb4f5815ff9c1d0ed5b7a9bd067a03</code></td>

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
