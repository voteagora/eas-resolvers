// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";
import {EAS} from "eas-contracts/EAS.sol";
import {ITransparentUpgradeableProxy, TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract UpgradeEntityResolverScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address initialAttester = 0xF6872D315CC2E1AfF6abae5dd814fd54755fE97C;
        EAS eas = EAS(0xC2679fBD37d54388Ce493F1DB75320D236e1815e);

        // Deploy new EntitiesResolver implementation
        EntitiesResolver implementation = new EntitiesResolver();

        ProxyAdmin proxyAdmin = ProxyAdmin(
            payable(0x0cf860e3529FEd1e410828b3c15d9Ec0aa17ccBa)
        );

        // Point to existing proxy
        TransparentUpgradeableProxy proxy = TransparentUpgradeableProxy(
            payable(0x69dAbd289CF35263b3940B7a0b495B10f9F2e254)
        );

        // Upgrade proxy to new implementation and call initialize
        proxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(address(proxy)),
            address(implementation),
            abi.encodeWithSelector(
                EntitiesResolver.initialize.selector,
                eas,
                initialAttester
            )
        );

        vm.stopBroadcast();

        console.log(
            "EntityResolver is now available at proxy address:",
            address(proxy)
        );
    }
}
