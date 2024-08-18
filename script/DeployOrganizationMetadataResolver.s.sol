// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";
import {EAS} from "eas-contracts/EAS.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract DeployOrganizationMetadataResolverScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address initialAttester = 0xA18D0226043A76683950f3BAabf0a87Cfb32E1Cb;
        address owner = 0xEA64B234316728f1BFd3b7cDCc1EAf0066D8E055;

        EAS eas = EAS(0xC2679fBD37d54388Ce493F1DB75320D236e1815e);

        // Deploy ProjectAttesterResolver contract
        EntitiesResolver implementation = new EntitiesResolver();

        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(implementation),
            0xA18D0226043A76683950f3BAabf0a87Cfb32E1Cb,
            abi.encodeWithSelector(
                EntitiesResolver.initialize.selector,
                eas,
                owner,
                initialAttester
            )
        );

        vm.stopBroadcast();

        console.log(
            "Deployed OrganizationMetadataResolver at address:",
            address(proxy)
        );
    }
}
