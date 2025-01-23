// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {ProjectModuleResolver} from "../src/ProjectModuleResolver.sol";
import {EAS} from "eas-contracts/EAS.sol";
import {ITransparentUpgradeableProxy, TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract UpgradeEntityResolverToProjectModuleScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy ProjectModuleResolver implementation
        ProjectModuleResolver implementation = new ProjectModuleResolver();

        ProxyAdmin proxyAdmin = ProxyAdmin(
            payable(0xC62913d3c526baa0e20bac67BAf9E383137CDAE2)
        );

        // Point to existing proxy
        TransparentUpgradeableProxy proxy = TransparentUpgradeableProxy(
            payable(0x609b5e82CD85787101Ad05426fFfA5958521F5c5)
        );

        // Upgrade proxy to new implementation and call initialize
        proxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(address(proxy)),
            address(implementation),
            bytes("")
        );

        vm.stopBroadcast();

        console.log(
            "ProjectModuleResolver is now available at proxy address:",
            address(proxy)
        );
    }
}
