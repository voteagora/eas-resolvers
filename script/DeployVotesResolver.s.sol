// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {VotesResolver} from "../src/VotesResolver.sol";
import {EAS} from "eas-contracts/EAS.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract DeployVotesResolverScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address owner = 0xE7402214476843d4b59F455AB048ac71225D30D6;

        // Optimism Mainnet
        // EAS eas = EAS(0x4200000000000000000000000000000000000021);
        // Sepolia
        EAS eas = EAS(0xC2679fBD37d54388Ce493F1DB75320D236e1815e);

        // Deploy VotesResolver contract
        VotesResolver implementation = new VotesResolver();

        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(implementation),
            owner,
            abi.encodeWithSelector(
                VotesResolver.initializeVotesResolver.selector,
                eas,
                owner
            )
        );

        vm.stopBroadcast();

        console.log("Deployed VotesResolver at address:", address(proxy));
    }
}
