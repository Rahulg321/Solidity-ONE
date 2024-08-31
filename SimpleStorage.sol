// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage{
    // boolean, uint, int, address bytes
    bool hasFavoriteNumber = false;

    uint public favoriteNumber;

    // the default visibility is internal means can only be called by the contract 
    string TextNumber = "five";



    address myAddress = 0x8e7E00d5ba604699B11F69C459b1A01174d6c5b4;
    bytes32 myBytes = "cat";


    function store(uint256 _favoriteNum) public {
        favoriteNumber = _favoriteNum;
    }


    // a view function/keyword implies that we are only going to read state from this function and not do anything

    // view and pure function disallow modification of state

    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

}
