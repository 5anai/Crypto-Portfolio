//
//  Loaders.swift
//  CryptoChameleon
//
//  Created by Sanay Fatullayeva on 14.01.22.
//

import Foundation
import SwiftUI

func setCoin(portfolio: Portfolio, currencyList: [String : Int], currency: String, quantity: String){
    for coin in portfolio.coins{
        if coin.name == currency{
            portfolio.portfolioList.append(coin)
        }
    }
    
    for coin in portfolio.portfolioList{
        let qty = currencyList[coin.name!]
        portfolio.totalPortfolioPrice = portfolio.totalPortfolioPrice + (Double(coin.priceUSD!)! * Double(qty!))
    }
    
    getDayChange(portfolio: portfolio)
}

func getDayChange(portfolio: Portfolio){
    var totalOldPrice = 0.0
    var totalNowPrice = 0.0
    
    for coin in portfolio.portfolioList{
        let p = Double(coin.dayPercentChange!)!/100
        let difference = p * Double(coin.priceUSD!)!
        let oldPrice = Double(coin.priceUSD!)! - difference
        totalOldPrice = totalOldPrice + oldPrice
        
        totalNowPrice = totalNowPrice + Double(coin.priceUSD!)!
    }
    
    let singleCoinChange = portfolio.portfolioList.first?.dayPercentChange
    
    portfolio.totalPortfolioDayChange = (portfolio.portfolioList.count == 1) ? Double(singleCoinChange!)! : ((totalNowPrice - totalOldPrice ) / totalOldPrice) * 100
}

func callLore(portfolio: Portfolio){
    let decoder = JSONDecoder()
    
    if let apiURL = URL(string: "https://api.coinlore.net/api/tickers/"){
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let decodedData = try decoder.decode(Tickers.self, from: data!)
                print("DECODED DATA: \(decodedData)")
                portfolio.coins = decodedData.data
            }catch let err{
                print(err)
            }
            
        }.resume()
    }
}

func setCoins(portfolio: Portfolio, currencyList: [String : Int]){
    portfolio.coins = []
    portfolio.portfolioList = []
    portfolio.totalPortfolioPrice = 0.0
    portfolio.totalPortfolioDayChange = 0.0
    
    for coin in portfolio.coins{
        for (currency, quantity) in currencyList{
            if coin.name == currency{
                portfolio.portfolioList.append(coin)
            }
        }
    }
    
    for coin in portfolio.portfolioList{
        let qty = currencyList[coin.name!]
        portfolio.totalPortfolioPrice = portfolio.totalPortfolioPrice + (Double(coin.priceUSD!)! * Double(qty!))
    }
    
    getDayChange(portfolio: portfolio)
}

func refresh(portfolio: Portfolio, currencyList: [String:Int]){
    let selectedCurrencies = Array(currencyList.keys)
    portfolio.portfolioList = []
    
    
    for coin in portfolio.coins{
        for selectedCurrency in selectedCurrencies{
            if selectedCurrency == coin.name{
                portfolio.portfolioList.append(coin)
            }
        }
    }
}
