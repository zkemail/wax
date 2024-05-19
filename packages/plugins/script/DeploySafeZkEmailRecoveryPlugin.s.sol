// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "../src/safe/SafeZkEmailRecoveryPlugin.sol";

contract Deploy is Script {
    using ECDSA for *;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        if (deployerPrivateKey == 0) {
            console.log("PRIVATE_KEY env var not set");
            return;
        }

        vm.startBroadcast(deployerPrivateKey);

        // Deploy DKIM registry
        SafeZkEmailRecoveryPlugin safeZkEmailRecoveryPlugin = new SafeZkEmailRecoveryPlugin(
            0xbabFc29e79b4935e1B99515c02354CdA2c2fDA6A, // Verifier
            0x2D3908e61B436A80bfDDD2772E7179da5A87a597, // DKIMRegistry
            0x87c0F604256f4C92D7e80699238623370e266A16 // EmailAuthImpl
        );
        console.log("SafeZkEmailRecoveryPlugin deployed at: %s", address(safeZkEmailRecoveryPlugin));

        vm.stopBroadcast();
    }
}
