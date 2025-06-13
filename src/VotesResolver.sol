// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {UpgradableSchemaResolver} from "./UpgradableSchemaResolver.sol";
import {IEAS} from "eas-contracts/IEAS.sol";
import {Attestation} from "eas-contracts/Common.sol";

contract VotesResolver is UpgradableSchemaResolver {
    error InvalidAttester();
    error AlreadyVoted();
    error VoterMustBeAttester();
    error InvalidVoterAttestation();

    event VoteCast(uint256 indexed proposalId, address indexed voter, bytes32 indexed refUID, bytes data);

    bytes32 public VOTER_SCHEMA_UID;

    mapping(uint256 => mapping(address => bool)) internal _proposalVotes;

    function initialize(
        IEAS eas,
        address _owner,
        bytes32 _voterSchemaUID
    ) public initializer {
        UpgradableSchemaResolver.initialize(eas, _owner);
        VOTER_SCHEMA_UID = _voterSchemaUID;
    }

    function onAttest(
        Attestation calldata attestation,
        uint256 /*value*/
    ) internal override returns (bool) {
        if (attestation.recipient != attestation.attester) {
            revert VoterMustBeAttester();
        }

        Attestation memory citizenAttestation = _eas.getAttestation(attestation.refUID);
	
        if (citizenAttestation.schema != VOTER_SCHEMA_UID || citizenAttestation.revocationTime != 0 || citizenAttestation.recipient != attestation.recipient) {
          revert InvalidVoterAttestation();
        }

        // Decode the data into the schema
        (uint256 proposalId, ) = abi.decode(
            attestation.data,
            (uint256, string)
        );

        if (_proposalVotes[proposalId][attestation.recipient]) {
            revert AlreadyVoted();
        }
	
        _countVote(attestation.recipient, proposalId);

        emit VoteCast(proposalId, attestation.recipient, attestation.refUID, attestation.data);
	
	      return true;
    }

    function _countVote(address recipient, uint256 proposalId) internal {
        _proposalVotes[proposalId][recipient] = true;
    }

    function onRevoke(
        Attestation calldata /*attestation*/,
        uint256 /*value*/
    ) internal pure override returns (bool) {
        return true;
    }
}
