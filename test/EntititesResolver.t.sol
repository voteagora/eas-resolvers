// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "forge-std/console.sol";
import {Test, console} from "forge-std/Test.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {EAS} from "eas-contracts/EAS.sol";
import {IEAS} from "eas-contracts/IEAS.sol";
import {AttestationRequestData, AttestationRequest} from "eas-contracts/IEAS.sol";
import {Utils} from "test/utils/Utils.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract EntitiesResolverTest is Test {
    error InvalidAttester();

    SchemaRegistry public schemaRegistry;
    EAS public eas;
    EntitiesResolver public entitiesResolver;

    bytes32 private _testSchemaUID;

    function setUp() public {
        schemaRegistry = new SchemaRegistry();
        eas = new EAS(schemaRegistry);
        EntitiesResolver implementation = new EntitiesResolver();

        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(implementation),
            address(this),
            abi.encodeWithSelector(
                EntitiesResolver.initialize.selector,
                eas,
                address(this),
                address(this)
            )
        );

        _setUp(payable(proxy));

        _testSchemaUID = schemaRegistry.register(
            "uint256 farcasterID, string type",
            entitiesResolver,
            true
        );
    }

    function _setUp(address payable proxy) public virtual {
        entitiesResolver = EntitiesResolver(proxy);
    }

    function test_Attest() public {
        vm.expectEmit();

        bytes32 uid = eas.attest(
            AttestationRequest({
                schema: _testSchemaUID,
                data: AttestationRequestData({
                    recipient: address(Utils.alice),
                    expirationTime: 0,
                    refUID: 0x0,
                    revocable: true,
                    data: abi.encodeWithSignature(
                        "uint256 farcasterID, string type",
                        1,
                        "Project"
                    ),
                    value: 0
                })
            })
        );

        emit IEAS.Attested(
            address(Utils.alice),
            address(this),
            uid,
            _testSchemaUID
        );
    }

    function test_InvalidAttester() public {
        vm.expectRevert(InvalidAttester.selector);

        vm.prank(address(Utils.alice));
        eas.attest(
            AttestationRequest({
                schema: _testSchemaUID,
                data: AttestationRequestData({
                    recipient: address(Utils.alice),
                    expirationTime: 0,
                    refUID: 0x0,
                    revocable: true,
                    data: abi.encodeWithSignature(
                        "uint256 farcasterID, string type",
                        1,
                        "Project"
                    ),
                    value: 0
                })
            })
        );
    }

    function test_setAttester() public {
        vm.expectEmit();

        entitiesResolver.setAttester(address(Utils.alice));

        emit EntitiesResolver.AttesterChanged(address(Utils.alice));
    }
}
