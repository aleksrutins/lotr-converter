//
//  Currency.swift
//  LOTR Converter
//
//  Created by Aleks Rutins on 6/30/23.
//

import Foundation
import SwiftUI

struct ExchangeRate : Identifiable {
    var id: String { "convert-\(from.rawValue)-to-\(to.rawValue)-at-\(rate)" }
    let from: Currency
    let to: Currency
    let rate: Double
    
    var info: some View {
        let fromImage = from.rawValue.replacingOccurrences(of: " ", with: "").lowercased()
        let toImage = to.rawValue.replacingOccurrences(of: " ", with: "").lowercased()
        return HStack {
            Image(fromImage).resizable().scaledToFit().frame(height: 33)
            Text("1 \(from.rawValue) = \(Int(rate)) \(to.rawValue)")
            Image(toImage).resizable().scaledToFit().frame(height: 33)
        }
    }
}

enum Currency : String, CaseIterable {
    case copperPenny = "Copper Penny"
    case silverPenny = "Silver Penny"
    case silverPiece = "Silver Piece"
    case goldPenny = "Gold Penny"
    case goldPiece = "Gold Piece"
    
    static let exchangeRates = [
        ExchangeRate(from: .goldPiece, to: .goldPenny, rate: 4),
        ExchangeRate(from: .goldPiece, to: .silverPiece, rate: 16),
        ExchangeRate(from: .goldPiece, to: .silverPenny, rate: 64),
        ExchangeRate(from: .goldPiece, to: .copperPenny, rate: 6400),
        
        ExchangeRate(from: .goldPenny, to: .silverPiece, rate: 4),
        ExchangeRate(from: .goldPenny, to: .silverPenny, rate: 16),
        ExchangeRate(from: .goldPenny, to: .copperPenny, rate: 1600),
        
        ExchangeRate(from: .silverPiece, to: .silverPenny, rate: 4),
        ExchangeRate(from: .silverPiece, to: .copperPenny, rate: 400),
        
        ExchangeRate(from: .silverPenny, to: .copperPenny, rate: 100)
        
    ]
    
    func convert(_ amount: Double, to: Currency) -> Double {
        var backwards = false
        var rate = Currency.exchangeRates.first {$0.from == self && $0.to == to}
        
        if rate == nil {
            rate = Currency.exchangeRates.first {$0.to == self && $0.from == to}
            backwards = true
        }
        
        if rate == nil {
            return amount
        }
        
        if backwards {
            return amount / rate!.rate
        } else {
            return amount * rate!.rate
        }
    }
}

extension Currency : Identifiable {
    var id: RawValue { rawValue }
}

struct CurrencyValue {
    var currency: Currency
    var stringValue: String
    var value: Double? { Double(stringValue) }
    
    func convert(to newCurrency: Currency) -> CurrencyValue {
        return CurrencyValue(currency: newCurrency, stringValue: String(currency.convert(value ?? 0, to: newCurrency)))
    }
}
