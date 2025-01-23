// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {UpgradableSchemaResolver} from "./UpgradableSchemaResolver.sol";
import {IEAS} from "eas-contracts/IEAS.sol";
import {Attestation} from "eas-contracts/Common.sol";

contract ProjectModuleResolver is UpgradableSchemaResolver {
    error InvalidAttester();
    error InvalidEntityType();

    event AttesterChanged(address indexed attester);

    address public attester;

    function initialize(
        IEAS eas,
        address _owner,
        address _attester
    ) public initializer {
        UpgradableSchemaResolver.initialize(eas, _owner);
        attester = _attester;

        emit AttesterChanged(_attester);
    }

    function setAttester(address _attester) public onlyOwner {
        attester = _attester;

        emit AttesterChanged(_attester);
    }

    function onAttest(
        Attestation calldata attestation,
        uint256 /*value*/
    ) internal override returns (bool) {
        if (attestation.attester != attester) {
            revert InvalidAttester();
        }

        Attestation memory entity = _eas.getAttestation(attestation.refUID);

        // Decode the data into the schema
        (, string memory entityType) = abi.decode(
            entity.data,
            (uint256, string)
        );

        if (keccak256(abi.encodePacked(entityType)) != keccak256("project")) {
            revert InvalidEntityType();
        }

        return true;
    }

    function onRevoke(
        Attestation calldata /*attestation*/,
        uint256 /*value*/
    ) internal pure override returns (bool) {
        return true;
    }
}
