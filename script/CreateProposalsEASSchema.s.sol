// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {ISchemaResolver} from "eas-contracts/resolver/ISchemaResolver.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";

contract CreateProposalsEASSchemaScript is Script {
    // Optimism Mainnet
    SchemaRegistry schemaRegistry =
        SchemaRegistry(payable(0x4200000000000000000000000000000000000020));
    EntitiesResolver entitiesResolver =
        EntitiesResolver(payable(0x2d69e3Fa434898999FaEfe0EdBc8a714C4a0fE0F));


    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Create new EAS schema
        bytes32 schemaId = schemaRegistry.register(
            "address contract,uint256 id,address proposer,string description,string[] choices,uint8 proposal_type_id,uint256 start_block,uint256 end_block,string proposal_type,uint256[] tiers,uint256 onchain_proposalid,uint8 max_approvals,uint8 criteria,uint128 criteria_value,uint8 calculationOptions",
            entitiesResolver,
            true
        );

        vm.stopBroadcast();
    }
}
