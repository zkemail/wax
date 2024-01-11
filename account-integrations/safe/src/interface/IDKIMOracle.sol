// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IDKIMOracleRegistry} from "./interface/IDKIMOracleRegistry.sol";

// TODO natspec
interface IDKIMOracle {
    function addRegistry(IDKIMOracleRegistry registry) external;
    function removeRegistry(IDKIMOracleRegistry registry) external;
    function requestUpdate(string memory domainName) external;
}
