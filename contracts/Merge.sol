//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Merge {
    function MergeSorted(int256[] calldata a, int256[] calldata b) public pure returns (int256[] memory) {
        uint256 x = a.length;
        uint256 y = b.length;
        int256[] memory result = new int256[](x+y);
        uint256 i = 0;
        uint256 j = 0;
        uint256 k = 0;
        while (i < x && j < y) {
            if (a[i] < b[j]) {
                result[k] = a[i];
                i++;                
            }else {
                result[k] = b[j];
                j++;
            }
            k++;
        }
        while(i < x) {
            result[k] = a[i];
            i++;
            k++;
        }
        while(j < y) {
            result[k] = b[j];
            j++;
            k++;
        }
        return result;
    }
}