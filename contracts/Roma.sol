//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RomaConvert {
    mapping(bytes1 => uint) roma;
    mapping(string => uint) special;

    constructor() {
        roma[bytes1("I")] = 1;
        roma[bytes1("V")] = 5;
        roma[bytes1("X")] = 10;
        roma[bytes1("L")] = 50;
        roma[bytes1("C")] = 100;
        roma[bytes1("D")] = 500;
        roma[bytes1("M")] = 1000;
        special["IV"] = 4;
        special["IX"] = 9;
        special["XL"] = 40;
        special["XC"] = 90;
        special["CD"] = 400;
        special["CM"] = 900;
    }

    function ToNumber(string calldata str) public view returns (uint256) {
        bytes memory b = bytes(str);
        bytes memory combined = new bytes(2);
        uint256 result = 0;
        for (int i = int(b.length - 1); i >= 0; i--) {
            if (i >= 1) {
                combined[0] = b[uint(i - 1)];
                combined[1] = b[uint(i)];
                if (special[string(combined)] > 0) {
                    result += uint256(special[string(combined)]);
                    i--;
                }else {
                    result += roma[b[uint(i)]];
                }
                
            } else {
                result += roma[b[uint(i)]];
            }        
        }
        return result;
    }
}
