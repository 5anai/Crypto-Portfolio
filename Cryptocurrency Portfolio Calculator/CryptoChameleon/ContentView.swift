//
//  ContentView.swift
//  CryptoChameleon
//
//  Created by Sanay Fatullayeva on 14.01.22.
//

import SwiftUI
import Foundation


struct ContentView: View {
    @State private var currency = ""
    @State private var quantity = ""
    @StateObject var portfolio = Portfolio()
    @State private var currencyList: [String:Int] = [:]
    @State private var showingAlert = false
    
    
    @State private var toggle: Bool = false
    @State private var showModal: Bool = false
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack{
            HStack{
                if toggle {
                    HStack{
                        Text("Day \nChange:")
                        Image(systemName: (Double(portfolio.totalPortfolioDayChange) ) >= 0 ?
                              "arrow.up" :  "arrow.down")
                            .foregroundColor((Double(portfolio.totalPortfolioDayChange) ) >= 0 ?
                                             Color.green : Color.red)
                        
                        Text("\(String(format: "%.2f", portfolio.totalPortfolioDayChange))")
                            .foregroundColor(
                                (Double(portfolio.totalPortfolioDayChange) ) >= 0 ?
                                Color.green : Color.red)
                    }
                    
                    HStack{
                        Text("Portfolio \n Price:")
                        Text("$  \(String(format: "%.2f", portfolio.totalPortfolioPrice))")
                    }
                }
            }
            
            List{
                ForEach(portfolio.portfolioList){ coin in
                    CoinView(coin: coin)
                }.onDelete(perform: delete)
                    .listRowSeparator(.hidden)
            }
            
            Button(action: {
                showModal = true
                
            }) {
                HStack{
                    Image(systemName: "plus")
                    Text("Add Coin")
                        
                }
            }.sheet(isPresented: $showModal, content: {
              
                
                VStack{
                    TextField("Currency", text: $currency)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accentColor(.mint)

                             
                    TextField("Quantity", text: $quantity)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accentColor(.mint)
                }
                
                Button {
                    if currencyList[currency] == nil && ((quantity != "") || (currency != "")){
                        currencyList[currency] = Int(quantity)
                        setCoin(portfolio: portfolio, currencyList: currencyList, currency: currency, quantity: quantity)
                        currency = ""
                        quantity = ""
                        toggle = true
                        showModal = false
                    }else{
                        print("\(currency) exists or currency/quantity missing, didn't add anything")
                        currency = ""
                        quantity = ""
                        showModal = false
                        showingAlert = true
                    }
                } label: {
                    
                    Text(" SUBMIT ")
                        .bold()
                        .frame(width: 100, height: 40, alignment: .center)
                        .background(Color.blue.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 90))
                }
            })
        }.onAppear(perform: {
            callLore(portfolio: portfolio)
        })
    }
    
    func delete(at offsets: IndexSet){
        if let ndx = offsets.first{
            portfolio.portfolioList.remove(at: ndx)
            setCoin(portfolio: portfolio, currencyList: currencyList, currency: currency, quantity: quantity)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
