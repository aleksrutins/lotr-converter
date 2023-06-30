//
//  CurrencyEntry.swift
//  LOTR Converter
//
//  Created by Aleks Rutins on 6/30/23.
//

import SwiftUI
import Combine

struct CurrencyEntry: View {
    @Binding var value: CurrencyValue
    @State var editable: Bool

    var picker: some View {
        Picker("Currency", selection: $value.currency) {
            ForEach(Currency.allCases) { currency in
                Text(currency.rawValue).tag(currency)
            }
        }
    }
    
    var body: some View {
        GroupBox {
            picker
            TextField("Amount", text: $value.stringValue)
                .keyboardType(.numberPad)
                .onReceive(Just(value.stringValue)) { newValue in
                    let filtered = newValue.filter { "0123456789.,".contains($0) }
                    if filtered != newValue {
                        value.stringValue = filtered
                    }
                }
                .disabled(!editable)
            
        }
    }
}
