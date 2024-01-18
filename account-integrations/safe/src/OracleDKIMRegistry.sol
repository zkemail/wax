// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {DKIMRegistry} from "@zk-email/contracts/DKIMRegistry.sol";
import {IDKIMOracle} from "./interface/IDKIMOracle.sol";
import {IDKIMOracleRegistry} from "./interface/IDKIMOracleRegistry.sol";

/// @title OracleDKIMRegsitry
/// @notice A DKIM Registry that could be updated by an oracle network such as Chainlink, UMA, etc.
// TODO Add note this is based on https://github.com/zkemail/email-wallet/blob/main/packages/contracts/src/utils/ECDSAOwnedDKIMRegistry.sol#170
contract OracleDKIMRegsitry is Ownable, IDKIMOracleRegistry {
    DKIMRegistry public dkimRegistry;
    IDKIMOracle public dkimOracle;

    mapping(string => bytes32) public domainToCurrentPublicKeyHash;

    constructor(IDKIMOracle _dkimOracle) {
        dkimRegistry = new DKIMRegistry();

        dkimOracle = _dkimOracle;
        dkimOracle.addRegistry(dkimRegistry);
    }

    function isDKIMPublicKeyHashValid(
        string memory domainName,
        bytes32 publicKeyHash
    ) public view returns (bool) {
        return dkimRegistry.isDKIMPublicKeyHashValid(domainName, publicKeyHash);
    }

    function updateOracle(IDKIMOracle _dkimOracle) onlyOwner external {
        dkimOracle.removeRegistry(dkimRegistry);
        dkimOracle = _dkimOracle;
        dkimOracle.addRegistry(dkimRegistry);
    }

    function requestUpdate(string memory domainName) external {
        dkimOracle.requestUpdate(domainName);
    }

    // TODO figure out how we want to handle this selector
    function handleUpdate(
        string memory selector,
        string memory domainName,
        bytes32 publicKeyHash
    ) external onlyOracle {
        // Check update is valid
        require(bytes(selector).length != 0, "Invalid selector");
        require(bytes(domainName).length != 0, "Invalid domain name");
        require(publicKeyHash != bytes32(0), "Invalid public key hash");
        require(isDKIMPublicKeyHashValid(domainName, publicKeyHash) == false, "publicKeyHash is already set");
        require(dkimRegistry.revokedDKIMPublicKeyHashes(publicKeyHash) == false, "publicKeyHash is revoked");

        // Update registry
        dkimRegistry.setDKIMPublicKeyHash(domainName, publicKeyHash);

        // Revoke exisiting
        bytes32 currentPubKeyHash = domainToCurrentPublicKeyHash[domainName];
        dkimRegistry.revokeDKIMPublicKeyHash(currentPubKeyHash);
        domainToCurrentPublicKeyHash[domainName] = publicKeyHash;
    }

    modifier onlyOracle() {
        _checkOracle();
        _;
    }

    function _checkOracle() internal view virtual {
        require(dkimOracle == msg.sender, "OracleDKIMRegsitry: caller is not oracle");
    }
}
