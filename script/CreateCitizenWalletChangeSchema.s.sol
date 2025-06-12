// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";

contract CreateCitizenWalletChangeSchemaScript is Script {
    // Optimism Mainnet
    SchemaRegistry schemaRegistry =
        SchemaRegistry(payable(0x4200000000000000000000000000000000000020));
    EntitiesResolver entitiesResolver =
        EntitiesResolver(payable(0x60E3B3C7df1237183C69AB13F3D5217e83a0f076));

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Create new EAS schema
        bytes32 schemaId = schemaRegistry.register(
            "bytes32 oldCitizenUID",
            entitiesResolver,
            true
        );

        vm.stopBroadcast();
    }
}
