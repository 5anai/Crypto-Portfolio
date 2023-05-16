//
//  CoinView.swift
//  CryptoChameleon
//
//  Created by Sanay Fatullayeva on 08.02.22.
//

import Foundation
import SwiftUI

struct CoinView: View {
    var coin: Tickers.Coin
    
    var body: some View {
        HStack(spacing: 0){
            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.black)
            Spacer()
            VStack(alignment: .trailing){
                
                Text("$\(coin.priceUSD!)")
                    .bold()
                    .foregroundColor(.black)
                
                Text("\(coin.dayPercentChange!)")
                    .foregroundColor(
                        (Double(coin.dayPercentChange!) ?? 0.0) >= 0 ?
                        Color.green : Color.red
                    )
            }
        }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView(coin: Tickers.Coin())
    }
}
