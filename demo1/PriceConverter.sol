// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
     function getPrice() internal view returns(uint256) {
        AggregatorV3Interface priceFeed =  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        // we need to maintain the order of the returned elements
        (, int answer,,,) =  priceFeed.latestRoundData();

        // returns the price of 1eth in USD
        return uint256(answer * 1e10);
    }

    
    function getVersion() internal view returns (uint256) {
       AggregatorV3Interface priceFeed =  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
       return priceFeed.version();
    }


    function getConversionRate(uint256 ethAmount)internal view returns (uint256){
        // pass in ethers and get the total value in USD

        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

}