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
<td>Entity (Optimism Mainnet)</td>
<td><code>0x2C6706cb5bC82c5985F3937391F5BE1D8dE96B12</code></td>
<td><code>0x821f75Cb1D4B3044cB4443dA9fFF6Bee4E7bc5B5</code></td>
<td><code>0xff0b916851c1c5507406cfcaa60e5d549c91b7f642eb74e33b88143cae4b47d0</code></td>
</tr>
<tr>
<td>Entity (Sepolia)</td>
<td><code>0xfA93d7364fCe1056EAab591DF1C0b01aBCa37461</code></td>
<td><code>0xaDAAca76f4825F1b7241E05A0657Daec4EcFfe39</code></td>
<td><code>0x5eefb359bc596699202474fd99e92172d1b788aa34280f385c498875d1bfb424</code></td>
</tr>
<tr>
<td>Organization Metadata (Optimism Mainnet)</rd>
<td><code>0x630A6A268191c654ce084aAd2D7910fF651e0797</code></td>
<td><code>0xd07C24D3DaaA016026E7b653557f4F5793dEf9bA</code></td>
<td><code>0xc2b376d1a140287b1fa1519747baae1317cf37e0d27289b86f85aa7cebfd649f</code></td>
</tr>
<tr>
<td>Organization Metadata (Sepolia)</td>
<td><code>0x0287cf4e225B02D42D90d626C6233cf7F0c7103d</code></td>
<td><code>0xDdD8B952aE933584F3caEBfFCDB2D5Fffdf86235</code></td>
<td><code>0x9c181f1e683fd2d79287d0b4fe1832f571fb4f5815ff9c1d0ed5b7a9bd067a03</code></td>
</tr>
<tr>
<td>Application (Sepolia)</td>
<td><code>0xcE372a175fb2769fe6ceF3fd24f31fE6f3AF59cc</code></td>
<td><code>0x88e3264Deae3536f66e9157058C4574eA71c7643</code></td>
<td><code>0xb50a1973d1aab9206545cd1da93e0dc1b5314989928bb35f58762020e2027154</code></td>
</tr>
<tr>
<td>Application (Optimism Mainnet)</td>
<td><code>0x5009C2b4e8083fE971446E6e20d79659cFB347BF</code></td>
<td><code>0x25c2b570A93BcA72516aa48768EF18010DB42ac2</code></td>
<td><code>0x2169b74bfcb5d10a6616bbc8931dc1c56f8d1c305319a9eeca77623a991d4b80</code></td>
</tr>
<tr>
<td>Citizens (Optimism Mainnet)</td>
<td><code>0xD08dCD25e2731Ce78B74A48c215ca2682B6C3EeA</code></td>
<td><code>0xa6722f13874C3CE97b4EDF6fc956bB44b656ADdA</code></td>
<td><code></code></td>
</tr>
<tr>
<td>Badgeholders (Optimism Mainnet)</td>
<td><code>0x5Ce933108e55481C17d1F586f0e21A426ae483b6</code></td>
<td><code>0x2f08A08f788510c0Ba5482158caCa02Ca3de9FD7</code></td>
<td><code></code></td>
</tr>
<tr>
<td>Foundation Mission Requests (Optimism Mainnet)</td>
<td><code>0xd22ea004a9a4EfeC545134959A01c9A890471145</code></td>
<td><code>0xB48cC46e8fA1b48B526e4c76c96013AEF8C1af88</code></td>
<td><code></code></td>
</tr>
<tr>
<td>Metagov Contribution (Optimism Mainnet)</td>
<td><code>0xdA08B1e305D7eA71332594E226bBc657890bB518</code></td>
<td><code>0x5787a988a4F029629CAB73761c84A19e1fe9a68B</code></td>
<td><code></code></td>
</tr>
<tr>
<td>Token house Grants (Optimism Mainnet)</td>
<td><code>0xf88fE93D5c3E63a5FFcdD997e73f77F596Dc6D1f</code></td>
<td><code>0xA6f56f6740DdE043d74e42e8BefDe9Abf42e3e03</code></td>
<td><code></code></td>
</tr>
<tr>
<td>Community Members (Optimism Mainnet)</td>
<td><code>0xEbC5344692f59A2CF3Fd09ED00aB2994eeB17c2e</code></td>
<td><code>0x2372358a7a883Eb66d2618A0c6B072A2b9BaA2f0</code></td>
<td><code></code></td>
</tr>
<tr>
<td>Superchain Members (Optimism Mainnet)</td>
<td><code>0x18B26cEc36C017b6f9302B969d3C00fBbC4C1a47</code></td>
<td><code>0x7E25d28f80A9629F6997499825027f0376DB6294</code></td>
<td><code></code></td>
</tr>
<tr>
<td>Verified Contract (Sepolia)</td>
<td><code>0x6Ecb721A75a0157E41B706b442D9a09202127D37</code></td>
<td><code>0x621178d144d2f9b4A062C8fBDf68F67FE39DeBd0</code></td>
<td><code>0x5e84bc14268e9bf1275ed4e796a9903e2c2c8b489a4de5f381a21634fe0fcb9a</code></td>
</tr>
<tr>
<td>Verified Contract (Optimism Mainnet)</td>
<td><code>0x609b5e82CD85787101Ad05426fFfA5958521F5c5</code></td>
<td><code>0xC62913d3c526baa0e20bac67BAf9E383137CDAE2</code></td>
<td><code>0xe687fc8f419477f1253c99889c28f3aee7e3472a4df28d3d20e88ced6acb1ddc</code></td>
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
forge script --rpc-url $OPTIMISM_RPC_URL --broadcast --verify -vvvv script/DeployVerifiedContractResolver.s.sol:DeployVerifiedContractResolverScript
forge script --rpc-url $OPTIMISM_RPC_URL --broadcast -vvvv script/CreateVerifiedContractEASSchema.s.sol:CreateVerifiedContractEASSchemaScript
```

You need to replace `SEPOLIA_RPC_URL` with the RPC url to which you want to deploy the contract.
Also, you'll need to set `PRIVATE_KEY` environment variable to the private key of the account that will deploy the contract.

### Upgrade

To upgrade the ProjectModuleResolver to the new implementation, run the following command:

```shell
forge script --rpc-url $OPTIMISM_RPC_URL --broadcast -vvvv script/UpgradeEntityResolverToProjectModule.sol:UpgradeEntityResolverToProjectModuleScript
```
