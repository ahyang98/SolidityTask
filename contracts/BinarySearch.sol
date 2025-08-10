//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract BinarySearch {
    function Search (int256[] calldata arr, int256 target) public pure returns (bool, uint256) {
        uint256 left = 0;
        uint256 right = arr.length -1;
        while (left < right) {
            uint256 mid = (left + right) /2;
            if (arr[mid] >= target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        if (arr[left] == target){
            return (true, left);
        } else {
            return (false, 0);
        }
        
    }
}