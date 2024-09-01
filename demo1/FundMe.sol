// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";


contract FundMe{

    using PriceConverter for uint256;

    uint256 minimumUsd = 50 * 1e18;

    // address of the people who send us money
    address[]  public funders;
    mapping(address => uint256) public adddressToAmountFunded;

    function fund () public payable  {
        // 1e8 is shorthand for 1×1081×108, which is 1 followed by 8 zeros, or 100,000,000.
        // require is a check
        // which makes sure that the condition passes
        require(msg.value.getConversionRate() >= minimumUsd,"send atleast 1ETH");   
        // msg.value -> 18 decimals
        funders.push(msg.sender);
        adddressToAmountFunded[msg.sender] = msg.value;
    }



   function withdraw () public {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) 
        {
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
        payable(msg.sender).transfer(address(this).balance);

        // send does not throw an error
        payable(msg.sender).send(address(this).balance);

    }
}