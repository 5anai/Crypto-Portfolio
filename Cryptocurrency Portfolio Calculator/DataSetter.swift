import Foundation
import SwiftUI
import CoreData

class Portfolio: ObservableObject{
    var coins: [Tickers.Coin] = []
    var portfolioList: [Tickers.Coin] = []
    @Published var totalPortfolioPrice: Double = 0.0
    @Published var totalPortfolioDayChange: Double = 0.0
    
    init() {
        
    }
}

struct Tickers: Decodable{
    var data: [Coin]
    
    enum TickersResponseKeys: String, CodingKey{
        case data = "data"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: TickersResponseKeys.self)
        data = try values.decode([Coin].self, forKey: .data)
    }
    
    struct Coin: Decodable, Identifiable{
        var id: String?
        var quantity: Double?
        var symbol: String?
        var name: String?
        var nameId: String?
        var rank: Int?
        var priceUSD: String?
        var dayPercentChange: String?
        var hourPercentChange: String?
        var weekPercentChange: String?
        var priceBTC: String?
        var marketCapUSD: String?
        var dayVolume: Double?
        var dayVolumeA: Double?
        var cSupply: String?
        var tSupply: String?
        var mSupply: String?
    
        enum CoinResponseKeys: String, CodingKey{
            case id = "id"
            case symbol = "symbol"
            case name = "name"
            case nameId = "nameid"
            case rank = "rank"
            case priceUsd = "price_usd"
            case dayPercentChange = "percent_change_24h"
            case hourPercentChange = "percent_change_1h"
            case weekPercentChange = "percent_change_7d"
            case priceBTC = "price_btc"
            case marketCapUSD = "market_cap_usd"
            case dayVolume = "volume24"
            case dayVolumeA = "volume24a"
            case cSupply = "csupply"
            case tSupply = "tsupply"
            case mSupply = "msupply"
        }
        
        init(from decoder: Decoder) throws{
            let values = try decoder.container(keyedBy: CoinResponseKeys.self)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            nameId = try values.decodeIfPresent(String.self, forKey: .nameId)
            rank = try values.decodeIfPresent(Int.self, forKey: .rank)
            priceUSD = try values.decodeIfPresent(String.self, forKey: .priceUsd)
            dayPercentChange = try values.decodeIfPresent(String.self, forKey: .dayPercentChange)
            hourPercentChange = try values.decodeIfPresent(String.self, forKey: .hourPercentChange)
            weekPercentChange = try values.decodeIfPresent(String.self, forKey: .weekPercentChange)
            priceBTC = try values.decodeIfPresent(String.self, forKey: .priceBTC)
            marketCapUSD = try values.decodeIfPresent(String.self, forKey: .marketCapUSD)
            dayVolume = try values.decodeIfPresent(Double.self, forKey: .dayVolume)
            dayVolumeA = try values.decodeIfPresent(Double.self, forKey: .dayVolumeA)
            cSupply = try values.decodeIfPresent(String.self, forKey: .cSupply)
            tSupply = try values.decodeIfPresent(String.self, forKey: .tSupply)
            mSupply = try values.decodeIfPresent(String.self, forKey: .mSupply)
        }
        
        init() {
            
        }
    }
}

