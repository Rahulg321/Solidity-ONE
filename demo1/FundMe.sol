// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Get funds from users
// withdraw funds, make sure that the person withdrawing is the owner
// set a minimum funding value in USD

import "./PriceConverter.sol";

// creating custom errors
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;
    address public immutable i_contractOwner;
    uint256 public constant MINIMUM_USD = 50 * 1e18;

    // address of the people who send us money
    address[] public funders;
    mapping(address => uint256) public adddressToAmountFunded;

    constructor() {
        i_contractOwner = msg.sender;
    }

    function fund() public payable {
        // 1e8 is shorthand for 1×1081×108, which is 1 followed by 8 zeros, or 100,000,000.
        // require is a check
        // which makes sure that the condition passes
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "send atleast 1ETH"
        );
        // msg.value -> 18 decimals
        funders.push(msg.sender);
        adddressToAmountFunded[msg.sender] += msg.value;
    }

    modifier onlyOwner() {
        // require(
        //     msg.sender == i_contractOwner,
        //     "only the owner can withdraw funds"
        // );
        if(msg.sender != i_contractOwner){revert NotOwner();}
        _;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            adddressToAmountFunded[funder] = 0;
        }
        // reset the array

        funders = new address[](0);
        //witdraw the funds

        // three different ways of sending ether
        // transfer
        // send
        // call

        // msg.sender -> address
        // payable(msg.sender) -> payabale address

        // transfer throws an error
        // payable(msg.sender).transfer(address(this).balance);

        // // send does not throw an error
        // bool withdrawSuccess = payable(msg.sender).send(address(this).balance);
        // require(withdrawSuccess,"withdraw of funds failed");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "call of funds failed");
    }


   receive() external payable { 
        fund();
    }


    fallback() external payable {
        fund();
    }

    // what if someone sends eth without calling the fund function

    // recieve()
    // fallback()
}
