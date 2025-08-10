//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract RevertString {   
    function Revert(string calldata str) public pure returns (string memory) {        
        bytes memory strBytes = bytes(str);
        uint256 len = strBytes.length;
        if (len == 0) {
            return "";
        }
        uint256 left = 0;
        uint256 right = len - 1;
        while (left < right) {
            // Swap characters
            (strBytes[left], strBytes[right]) = (strBytes[right], strBytes[left]);
            left++;
            right--;
        }
        return string(strBytes);
    }
}