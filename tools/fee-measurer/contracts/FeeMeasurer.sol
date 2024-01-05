//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract FeeMeasurer {
    // Note: Linter wants to restrict this to pure but that prevents calling this
    // in an actual transaction.
    function useGas(uint8 size) external {
        require(size != 0, "Size zero works differently due to zero-byte");

        uint256 iterations = 10 * uint256(size);

        for (uint256 i = 0; i < iterations; i++) {}
    }

    function useGasOrdinaryGasUsed(uint8 size) public pure returns (uint256) {
        require(size != 0, "Size zero works differently due to zero-byte");

        return 21629 + 1110 * uint256(size);
    }

    function fallbackOrdinaryGasUsed(
        uint256 nonZeroDataLen
    ) public pure returns (uint256) {
        require(nonZeroDataLen >= 4, "Formula doesn't work before 4 bytes");

        return 21142 + 16 * nonZeroDataLen;
    }

    fallback() external {}
}
