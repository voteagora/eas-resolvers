// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {UpgradableSchemaResolver} from "./UpgradableSchemaResolver.sol";
import {IEAS} from "eas-contracts/IEAS.sol";
import {Attestation} from "eas-contracts/Common.sol";

contract EntitiesResolver is UpgradableSchemaResolver {
    error InvalidAttester();

    address public attester;

    function initialize(IEAS eas, address _attester) public initializer {
        UpgradableSchemaResolver.initialize(eas);
        attester = _attester;
    }

    function onAttest(
        Attestation calldata attestation,
        uint256 /*value*/
    ) internal override returns (bool) {
        if (attestation.attester != attester) {
            revert InvalidAttester();
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
