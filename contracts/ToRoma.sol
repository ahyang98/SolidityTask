//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract ToRoma {
    mapping (uint => string) roma;
    constructor() {
        roma[1] = "I";
        roma[4] = "IV";
        roma[5] = "V";
        roma[9] = "IX";
        roma[10] = "X";
        roma[40] = "XL";
        roma[50] = "L";
        roma[90] = "XC";
        roma[100] = "C";
        roma[400] = "CD";
        roma[500] = "D";
        roma[900] = "CM";
        roma[1000] = "M";
    }
    function IntToRoma(uint256 number) public view returns (string memory) {
        require(number > 0 && number < 4000, "Number out of range");
        string memory result = "";
        uint[] memory values = new uint[](13);
        values[0] = 1000;
        values[1] = 900;
        values[2] = 500;
        values[3] = 400;
        values[4] = 100;
        values[5] = 90;
        values[6] = 50;
        values[7] = 40;
        values[8] = 10;
        values[9] = 9;
        values[10] = 5;
        values[11] = 4;
        values[12] = 1;

        for (uint i = 0; i < values.length; i++) {
            while (number >= values[i]) {
                result = string.concat(result, roma[values[i]]);
                number -= values[i];
            }
        }
        return result;
    }
}