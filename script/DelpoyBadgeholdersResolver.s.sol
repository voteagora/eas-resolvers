// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";
import {EAS} from "eas-contracts/EAS.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract DeployBadgeholdersResolverScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address initialAttester = 0xE4553b743E74dA3424Ac51f8C1E586fd43aE226F;
        address owner = 0xE7402214476843d4b59F455AB048ac71225D30D6;

        // Optimism Mainnet
        EAS eas = EAS(0x4200000000000000000000000000000000000021);

        // Deploy ProjectAttesterResolver contract
        EntitiesResolver implementation = new EntitiesResolver();

        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(implementation),
            0xE7402214476843d4b59F455AB048ac71225D30D6,
            abi.encodeWithSelector(
                EntitiesResolver.initialize.selector,
                eas,
                owner,
                initialAttester
            )
        );

        vm.stopBroadcast();

        console.log("Deployed EntityResolver at address:", address(proxy));
    }
}
