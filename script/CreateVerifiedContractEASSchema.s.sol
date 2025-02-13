// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";

contract CreateVerifiedContractEASSchemaScript is Script {
    // Optimism Mainnet
    // SchemaRegistry schemaRegistry =
    //     SchemaRegistry(payable(0x4200000000000000000000000000000000000020));
    // Sepolia
    SchemaRegistry schemaRegistry =
            SchemaRegistry(payable(0x0a7E2Ff54e76B8E6659aedc9103FB21c038050D0));
    EntitiesResolver entitiesResolver =
        EntitiesResolver(payable(0x6Ecb721A75a0157E41B706b442D9a09202127D37));

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Create new EAS schema
        bytes32 schemaId = schemaRegistry.register(
            "address contract, uint8 chainId, address deployer, bytes32 deploymentTx, bytes signature, uint8 verificationChainId, uint256 farcasterID",
            entitiesResolver,
            true
        );

        vm.stopBroadcast();
    }
}
