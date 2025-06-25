// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {ISchemaResolver} from "eas-contracts/resolver/ISchemaResolver.sol";
import {VotesResolver} from "../src/VotesResolver.sol";

contract CreateVotesEASSchemaScript is Script {
    // // Optimism Mainnet
    SchemaRegistry schemaRegistry =
        SchemaRegistry(payable(0x4200000000000000000000000000000000000020));
    VotesResolver votesResolver =
        VotesResolver(payable(0x147Ef4227718daa8C1786F91997C6ce0574D44aD));


    // Sepolia
    // SchemaRegistry schemaRegistry =
    //     SchemaRegistry(payable(0x0a7E2Ff54e76B8E6659aedc9103FB21c038050D0));
    // VotesResolver votesResolver =
    //     VotesResolver(payable(0xEbEA360971ac2A16Ed3eC3fb954552F55fc288C6));

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Create new EAS schema
        bytes32 schemaId = schemaRegistry.register(
            "uint256 proposalId,string params",
            votesResolver,
            true
        );

        vm.stopBroadcast();
    }
}
