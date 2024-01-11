// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IDKIMRegistry} from "@zk-email/contracts/interface/IDKIMRegistry.sol";
import {IDKIMOracle} from "./IDKIMOracle.sol";

// TODO natspec
interface IOracleDKIMRegsitry is IDKIMOracle {
    function updatePublicKeyHash(
        string memory domainName,
        bytes32 publicKeyHash
    ) external;
}
