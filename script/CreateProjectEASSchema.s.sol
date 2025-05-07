// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";

contract CreateProjectEASSchemaScript is Script {
    // Optimism Mainnet
    // SchemaRegistry schemaRegistry =
    //     SchemaRegistry(payable(0x4200000000000000000000000000000000000020));
    // Sepolia
    SchemaRegistry schemaRegistry =
        SchemaRegistry(payable(0x0a7E2Ff54e76B8E6659aedc9103FB21c038050D0));
    EntitiesResolver entitiesResolver =
        EntitiesResolver(payable(0xfd6C253B006067fA4EF06193533692565D37720f));

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Create new EAS schema
        bytes32 schemaId = schemaRegistry.register(
            "address issuer,string name,string category,bytes32 parentProjectRefUID,uint8 metadataType,string metadataUrl",
            entitiesResolver,
            true
        );

        vm.stopBroadcast();
    }
}
