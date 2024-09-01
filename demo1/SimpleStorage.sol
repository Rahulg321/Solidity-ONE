// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage{
    // boolean, uint, int, address bytes
    bool hasFavoriteNumber = false;
    // defining an array of strings
    string[] public names;
    uint  favoriteNumber;

    // the default visibility is internal means can only be called by the contract 
    string TextNumber = "five";

    // a dict that maps strings to numbers
    mapping(string => uint256) public nameToFavoriteNumber;

    address myAddress = 0x8e7E00d5ba604699B11F69C459b1A01174d6c5b4;
    bytes32 myBytes = "cat";

    // People public person1 = People({favoriteNumber:69, name:"Rahul"});

    People[] persons;

    // creating a custom type
    struct People {
        uint256 favoriteNumber;
        string name;
        string designation;
    }


    function store(uint256 _favoriteNum) public {
        favoriteNumber = _favoriteNum;
    }


    // a view function/keyword implies that we are only going to read state from this function and not do any mutation

    // view and pure function disallow modification of state

    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }


    // just pure function dont allow modification or reading just for performing some abstract calculation and returning it
    function add() public pure returns(uint256){
        return (1+1);
    }

    // calldata, memory, storage

    function addPeople(string memory _name, uint256 _favoriteNumber, string calldata _designation)
     public {

        // we cannot modify calldata arguements
        // _designation = "helloWorld";

        // since we dont modify this name variable after this function, we can keep it as memory or even calldata


        People memory newPerson = People({favoriteNumber:_favoriteNumber,name: _name,designation:_designation});
        persons.push(newPerson);
    }


      // calldata, memory, storage
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People({favoriteNumber:_favoriteNumber,name: _name, designation:"someone"});
        persons.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
