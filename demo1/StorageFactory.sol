// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory{

    // creating a contract from other one
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)public{
        // address
        // ABI - application binary interface
        // The ABI is a JSON format that describes the interface of a smart contract, including its functions, inputs, outputs, and events.

        // getting a contract from the array
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];    

        // calling a method from it
        simpleStorage.store(_simpleStorageNumber);
    }


    function sgGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();    
    }


}