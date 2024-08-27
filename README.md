## Optimism Identity protocol

Optimism identity protocol is powered by Ethereum Attestation Service (EAS). Current version of the protocol is centralized and requires a trusted entity to be the attester. This repository contains resolver smart contracts that will eventualy be used to manage permisisons and take over the need to trust a single entity.

<table>

<tr>
<th>Name</th>
<th>Resolver</th>
<th>Proxy Admin</th>
<th>Schema</th>
</tr>

<tr>
<tr>Entity (Optimism Mainnet)</tr>
<tr><code>0x2C6706cb5bC82c5985F3937391F5BE1D8dE96B12</code></tr>
<tr><code>0x821f75Cb1D4B3044cB4443dA9fFF6Bee4E7bc5B5</code></tr>
<tr><code>0xff0b916851c1c5507406cfcaa60e5d549c91b7f642eb74e33b88143cae4b47d0</code></tr>
</tr>

<tr>
<tr>Entity (Sepolia)</tr>
<tr><code>0xfA93d7364fCe1056EAab591DF1C0b01aBCa37461</code></tr>
<tr><code>0xaDAAca76f4825F1b7241E05A0657Daec4EcFfe39</code></tr>
<tr><code>0x5eefb359bc596699202474fd99e92172d1b788aa34280f385c498875d1bfb424</code></tr>
</tr>

<tr>
<tr>Organization Metadata (Optimism Mainnet)</tr>
<tr><code>0x630A6A268191c654ce084aAd2D7910fF651e0797</code></tr>
<tr><code>0xd07C24D3DaaA016026E7b653557f4F5793dEf9bA</code></tr>
<tr><code>0xc2b376d1a140287b1fa1519747baae1317cf37e0d27289b86f85aa7cebfd649f</code></tr>
</tr>

<tr>
<tr>Organization Metadata (Sepolia)</tr>
<tr><code>0x0287cf4e225B02D42D90d626C6233cf7F0c7103d</code></tr>
<tr><code>0xDdD8B952aE933584F3caEBfFCDB2D5Fffdf86235</code></tr>
<tr><code>0x9c181f1e683fd2d79287d0b4fe1832f571fb4f5815ff9c1d0ed5b7a9bd067a03</code></tr>
</tr>

<tr>
<tr>Citizens (Optimism Mainnet)</tr>
<tr><code>0xD08dCD25e2731Ce78B74A48c215ca2682B6C3EeA</code></tr>
<tr><code>0xa6722f13874C3CE97b4EDF6fc956bB44b656ADdA</code></tr>
<tr><code></code></tr>
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
