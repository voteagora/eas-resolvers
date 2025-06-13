// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {VotesResolver} from "../src/VotesResolver.sol";
import {SchemaRegistry} from "eas-contracts/SchemaRegistry.sol";
import {EAS} from "eas-contracts/EAS.sol";
import {IEAS, RevocationRequest, RevocationRequestData} from "eas-contracts/IEAS.sol";
import {AttestationRequestData, AttestationRequest} from "eas-contracts/IEAS.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ISchemaResolver} from "eas-contracts/resolver/ISchemaResolver.sol";

contract VotesResolverTest is Test {
    VotesResolver public votesResolver;
    SchemaRegistry public schemaRegistry;
    EAS public eas;
    address public alice = address(0xA11CE);
    address public bob = address(0xB0B);
    uint256 public proposalId = 1;
    bytes32 public votesSchemaUID;
    bytes32 public voterSchemaUID;
    bytes32 public voterAttestationUID;

    function setUp() public {
        schemaRegistry = new SchemaRegistry();
        eas = new EAS(schemaRegistry);
        VotesResolver implementation = new VotesResolver();

        voterSchemaUID = schemaRegistry.register(
            "uint256 farcasterID, string type",
            ISchemaResolver(address(0)), // no resolver
            true
        );

        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(implementation),
            address(this),
            abi.encodeWithSelector(
                VotesResolver.initialize.selector,
                eas,
                address(this),
                voterSchemaUID
            )
        );

        _setUp(payable(proxy));

        // Register schemas
        votesSchemaUID = schemaRegistry.register(
            "uint256 proposalId, string type",
            votesResolver,
            true
        );

        // Issue a Voter attestation for Alice
        voterAttestationUID = eas.attest(
            AttestationRequest({
                schema: voterSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: 0x0,
                    data: abi.encode(1, "Project"),
                    value: 0
                })
            })
        );
    }

    function _setUp(address payable proxy) public virtual {
        votesResolver = VotesResolver(proxy);
    }

    function test_SuccessfulVote() public {
        // Prepare vote attestation referencing the valid voter attestation
        vm.prank(alice);
        bytes32 voteUID = eas.attest(
            AttestationRequest({
                schema: votesSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: voterAttestationUID,
                    data: abi.encode(proposalId, "Project"),
                    value: 0
                })
            })
        );
        assertTrue(voteUID != bytes32(0), "Vote should succeed");
    }

    function test_PreventDoubleVoting() public {
        // First vote
        vm.prank(alice);
        eas.attest(
            AttestationRequest({
                schema: votesSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: voterAttestationUID,
                    data: abi.encode(proposalId, "Project"),
                    value: 0
                })
            })
        );
        // Second vote should revert
        vm.prank(alice);
        vm.expectRevert(VotesResolver.AlreadyVoted.selector);
        eas.attest(
            AttestationRequest({
                schema: votesSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: voterAttestationUID,
                    data: abi.encode(proposalId, "Project"),
                    value: 0
                })
            })
        );
    }

    function test_OnlyVoterCanAttest() public {
        // Bob tries to vote for Alice
        vm.prank(bob);
        vm.expectRevert(VotesResolver.VoterMustBeAttester.selector);
        eas.attest(
            AttestationRequest({
                schema: votesSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: voterAttestationUID,
                    data: abi.encode(proposalId, "Project"),
                    value: 0
                })
            })
        );
    }

    function test_InvalidVoterAttestation_Revoked() public {
        // Revoke the voter attestation
        eas.revoke(RevocationRequest({
            schema: voterSchemaUID,
            data: RevocationRequestData({
                uid: voterAttestationUID,
                value: 0
            })
        }));
        vm.prank(alice);
        vm.expectRevert(VotesResolver.InvalidVoterAttestation.selector);
        eas.attest(
            AttestationRequest({
                schema: votesSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: voterAttestationUID,
                    data: abi.encode(proposalId, "Project"),
                    value: 0
                })
            })
        );
    }

    function test_InvalidVoterAttestation_MismatchedRecipient() public {
        // Issue a voter attestation for Bob
        bytes32 bobVoterAttestationUID = eas.attest(
            AttestationRequest({
                schema: voterSchemaUID,
                data: AttestationRequestData({
                    recipient: bob,
                    expirationTime: 0,
                    revocable: true,
                    refUID: 0x0,
                    data: abi.encode(2, "Project"),
                    value: 0
                })
            })
        );
        // Alice tries to vote referencing Bob's voter attestation
        vm.prank(alice);
        vm.expectRevert(VotesResolver.InvalidVoterAttestation.selector);
        eas.attest(
            AttestationRequest({
                schema: votesSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: bobVoterAttestationUID,
                    data: abi.encode(proposalId, "Project"),
                    value: 0
                })
            })
        );
    }

    function test_InvalidVoterAttestation_WrongSchema() public {
        // Register a different schema
        bytes32 wrongSchemaUID = schemaRegistry.register(
            "uint256 wrongID, string type",
            ISchemaResolver(address(0)), // no resolver
            true
        );

        // Issue an attestation with the wrong schema
        bytes32 wrongAttestationUID = eas.attest(
            AttestationRequest({
                schema: wrongSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: 0x0,
                    data: abi.encode(1, "Project"),
                    value: 0
                })
            })
        );

        // Try to vote using the wrong schema attestation
        vm.prank(alice);
        vm.expectRevert(VotesResolver.InvalidVoterAttestation.selector);
        eas.attest(
            AttestationRequest({
                schema: votesSchemaUID,
                data: AttestationRequestData({
                    recipient: alice,
                    expirationTime: 0,
                    revocable: true,
                    refUID: wrongAttestationUID,
                    data: abi.encode(proposalId, "Project"),
                    value: 0
                })
            })
        );
    }
}
