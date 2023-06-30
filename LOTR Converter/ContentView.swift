//
//  ContentView.swift
//  LOTR Converter
//
//  Created by Aleks Rutins on 6/29/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var leftValue = CurrencyValue(currency: .silverPiece, stringValue: "0.0")
    @State private var rightValue = CurrencyValue(currency: .goldPiece, stringValue: "0.0")
    
    @State private var showInfo = false
    
    var body: some View {
        VStack {
            Text("Currency Exchange")
                .font(.bold(.largeTitle)())
            
            CurrencyEntry(value: $leftValue, editable: true)
                .cornerRadius(7)
                .onReceive(Just(leftValue)) { amount in
                    rightValue = amount.convert(to: rightValue.currency)
                }
            
            Image(systemName: "equal")
                .font(.largeTitle)
                .padding()
            
            CurrencyEntry(value: $rightValue, editable: false)
                .onReceive(Just(rightValue)) { amount in
                    rightValue = leftValue.convert(to: amount.currency)
                }
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    showInfo = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .fontDesign(.serif)
        .sheet(isPresented: $showInfo) {
            InfoSheet()
                .presentationDetents([.medium, .large])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
