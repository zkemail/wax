// TODO Remove and use ZKemail package version
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Interface for ZKEmail dkim registry
interface IDKIMRegsitry {
    function isDKIMPublicKeyHashValid(
        string memory domainName,
        bytes32 publicKeyHash
    ) external view returns (bool);
}
