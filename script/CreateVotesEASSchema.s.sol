// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {ISchemaResolver} from "eas-contracts/resolver/ISchemaResolver.sol";
import {VotesResolver} from "../src/VotesResolver.sol";

contract CreateVotesEASSchemaScript is Script {
    // // Optimism Mainnet
    // SchemaRegistry schemaRegistry =
    //     SchemaRegistry(payable(0x4200000000000000000000000000000000000020));
    // // SchemaRegistry(payable(0x0a7E2Ff54e76B8E6659aedc9103FB21c038050D0));


    // Sepolia
    SchemaRegistry schemaRegistry =
        SchemaRegistry(payable(0x0a7E2Ff54e76B8E6659aedc9103FB21c038050D0));
    VotesResolver votesResolver =
        VotesResolver(payable(0xC81c29694b15B8E84d3f0418F226a267aC2a6B96));

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
