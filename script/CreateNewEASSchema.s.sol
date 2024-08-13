// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";

contract CreateNewEASSchemaScript is Script {
    SchemaRegistry schemaRegistry =
        SchemaRegistry(payable(0x0a7E2Ff54e76B8E6659aedc9103FB21c038050D0));
    EntitiesResolver entitiesResolver =
        EntitiesResolver(payable(0x1622c09522f429Ce949dBc3C520D4004ddCcbb06));

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Create new EAS schema
        bytes32 schemaId = schemaRegistry.register(
            "uint256 farcasterID, string type",
            entitiesResolver,
            true
        );

        vm.stopBroadcast();
    }
}
