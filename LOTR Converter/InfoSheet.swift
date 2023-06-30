//
//  InfoSheet.swift
//  LOTR Converter
//
//  Created by Aleks Rutins on 6/30/23.
//

import SwiftUI

struct InfoSheet: View {
    var body: some View {
        VStack {
            
            Text("Exchange Rates")
                .font(.title)
            
            ForEach(Currency.exchangeRates) { rate in
                rate.info
            }
        }
        .fontDesign(.serif)
        .padding()
    }
}

struct InfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheet()
    }
}
