//
//  AddCurrencyView.swift
//  CryptoChameleon
//
//  Created by Sanay Fatullayeva on 15.03.22.
//

import SwiftUI

struct AddCurrencyView: View {
    @State var currency = ""
    @State var quantity = ""
    
    var body: some View {
        VStack{
            TextField("Currency", text: $currency)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accentColor(.mint)

                     
            TextField("Quantity", text: $quantity)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accentColor(.mint)
        }
    }
}

struct AddCurrencyView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddCurrencyView()
    }
}
