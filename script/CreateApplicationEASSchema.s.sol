// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";

contract CreateApplicationEASSchemaScript is Script {
    // Optimism Mainnet
    SchemaRegistry schemaRegistry =
        SchemaRegistry(payable(0x4200000000000000000000000000000000000020));
    // SchemaRegistry(payable(0x0a7E2Ff54e76B8E6659aedc9103FB21c038050D0));
    EntitiesResolver entitiesResolver =
        EntitiesResolver(payable(0x5009C2b4e8083fE971446E6e20d79659cFB347BF));

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Create new EAS schema
        bytes32 schemaId = schemaRegistry.register(
            "string round, uint256 farcasterID, bytes32 metadataSnapshotRefUID, uint8 metadataType, string metadataUrl",
            entitiesResolver,
            true
        );

        vm.stopBroadcast();
    }
}
