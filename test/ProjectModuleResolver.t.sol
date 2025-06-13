// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {ProjectModuleResolver} from "../src/ProjectModuleResolver.sol";
import {EntitiesResolver} from "../src/EntitiesResolver.sol";
import {IEAS, EAS} from "eas-contracts/EAS.sol";
import {AttestationRequestData, AttestationRequest} from "eas-contracts/IEAS.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {console2} from "forge-std/console2.sol";

contract ProjectModuleResolverTest is Test {
    EAS public eas;
    SchemaRegistry public registry;
    ProjectModuleResolver public projectModuleResolver;
    EntitiesResolver public entitiesResolver;
    
    address public owner;
    address public attester;
    bytes32 public entitySchemaUID;
    bytes32 public projectModuleSchemaUID;

    function setUp() public {
        // Setup accounts
        owner = makeAddr("owner");
        attester = makeAddr("attester");
        
        // Deploy EAS contracts
        registry = new SchemaRegistry();
        eas = EAS(0xC2679fBD37d54388Ce493F1DB75320D236e1815e);
        
        // Deploy implementation and proxy
        ProjectModuleResolver implementation = new ProjectModuleResolver();
        EntitiesResolver entitiesImplementation = new EntitiesResolver();

        // Setup EntitiesResolver proxy
        TransparentUpgradeableProxy entitiesProxy = new TransparentUpgradeableProxy(
            address(entitiesImplementation),
            address(this),
            abi.encodeWithSelector(
                EntitiesResolver.initialize.selector,
                eas,
                owner,
                attester
            )
        );

        // Setup ProjectModuleResolver proxy
        TransparentUpgradeableProxy projectProxy = new TransparentUpgradeableProxy(
            address(implementation),
            address(this),
            abi.encodeWithSelector(
                ProjectModuleResolver.initialize.selector,
                eas,
                owner,
                attester
            )
        );

        // Set resolver instances
        _setUp(payable(projectProxy), payable(entitiesProxy));
        
        // Register schemas
        vm.prank(attester);
        entitySchemaUID = registry.register(
            "uint256 farcasterID, string entity",
            entitiesResolver,
            true
        );
        
        vm.prank(attester);
        projectModuleSchemaUID = registry.register(
            "address contract, uint8 chainId, address deployer, bytes32 deploymentTx, bytes32 signature",
            projectModuleResolver,
            true
        );
    }

    function _setUp(address payable projectProxy, address payable entitiesProxy) public virtual {
        projectModuleResolver = ProjectModuleResolver(projectProxy);
        entitiesResolver = EntitiesResolver(entitiesProxy);
    }

    function test_ValidProjectModuleAttestation() public {
        // First create an entity attestation for a project
        bytes memory entityData = abi.encode(1, "project");
        
        vm.prank(attester);
        bytes32 entityUID = eas.attest(AttestationRequest({
            schema: entitySchemaUID,
            data: AttestationRequestData({
                recipient: address(0),
                expirationTime: 0,
                revocable: true,
                refUID: bytes32(0),
                data: entityData, 
                value: 0  
            })
        }));

        // Now create a project module attestation referencing the entity
        address moduleContract = makeAddr("moduleContract");
        address moduleDeployer = makeAddr("moduleDeployer");
        bytes32 deploymentTx = bytes32(uint256(1)); // Example transaction hash
        bytes32 signature = bytes32(uint256(2)); // Example signature

        bytes memory moduleData = abi.encode(
            moduleContract,
            uint8(10), // chainId
            moduleDeployer,
            deploymentTx,
            signature
        );
        
        vm.prank(attester);
        bytes32 moduleUID = eas.attest(AttestationRequest({
            schema: projectModuleSchemaUID,
            data: AttestationRequestData({
                recipient: address(0),
                expirationTime: 0,
                revocable: true,
                refUID: entityUID,
                data: moduleData,
                value: 0
            })
        }));

        // The attestation should have been created successfully
        assertTrue(moduleUID != bytes32(0));
    }

    function test_RevertWhenWrongAttester() public {
        // Create entity attestation
        bytes memory entityData = abi.encode(1, "project");
        
        vm.prank(attester);
        bytes32 entityUID = eas.attest(AttestationRequest({
            schema: entitySchemaUID,
            data: AttestationRequestData({
                recipient: address(0),
                expirationTime: 0,
                revocable: true,
                refUID: bytes32(0),
                data: entityData,
                value: 0
            })
        }));
        // Try to create module attestation with wrong attester
        address moduleContract = makeAddr("moduleContract");
        address moduleDeployer = makeAddr("moduleDeployer");
        bytes32 deploymentTx = bytes32(uint256(1));
        bytes32 signature = bytes32(uint256(2));

        bytes memory moduleData = abi.encode(
            moduleContract,
            uint8(10),
            moduleDeployer,
            deploymentTx,
            signature
        );
        
        address wrongAttester = makeAddr("wrongAttester");
        vm.prank(wrongAttester);
        vm.expectRevert(ProjectModuleResolver.InvalidAttester.selector);
        eas.attest(AttestationRequest({
            schema: projectModuleSchemaUID,
            data: AttestationRequestData({
                recipient: address(0),
                expirationTime: 0,
                revocable: true,
                refUID: entityUID,
                data: moduleData,
                value: 0
            })
        }));
    }

    function test_RevertWhenInvalidEntityType() public {
        // Create entity attestation with wrong type
        bytes memory entityData = abi.encode(1, "organization");
        
        vm.prank(attester);
        bytes32 entityUID = eas.attest(AttestationRequest({
            schema: entitySchemaUID,
            data: AttestationRequestData({
                recipient: address(0),
                expirationTime: 0,
                revocable: true,
                refUID: bytes32(0),
                data: entityData,
                value: 0
            })
        }));

        // Try to create module attestation referencing invalid entity
        address moduleContract = makeAddr("moduleContract");
        address moduleDeployer = makeAddr("moduleDeployer");
        bytes32 deploymentTx = bytes32(uint256(1));
        bytes32 signature = bytes32(uint256(2));

        bytes memory moduleData = abi.encode(
            moduleContract,
            uint8(10),
            moduleDeployer,
            deploymentTx,
            signature
        );
        
        vm.prank(attester);
        vm.expectRevert(ProjectModuleResolver.InvalidEntityType.selector);
        eas.attest(AttestationRequest({
            schema: projectModuleSchemaUID,
            data: AttestationRequestData({
                recipient: address(0),
                expirationTime: 0,
                revocable: true,
                refUID: entityUID,
                data: moduleData,
                value: 0
            })
        }));
    }
}
