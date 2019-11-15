//
//  SwiftBTC
//
//  Created by Otto Suess on 23.01.18.
//  Copyright © 2018 Zap. All rights reserved.
//

import Foundation

public struct FiatCurrency: Currency, Equatable, Codable {
    public let currencyCode: String
    public let symbol: String
    public let localized: String
    public let exchangeRate: Decimal

    private var currencyFormatter: NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.generatesDecimalNumbers = true
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.autoupdatingCurrent
        currencyFormatter.currencyCode = currencyCode
        return currencyFormatter
    }

    public init(currencyCode: String, symbol: String, localized: String, exchangeRate: Decimal) {
        self.currencyCode = currencyCode
        self.symbol = symbol
        self.localized = localized
        self.exchangeRate = exchangeRate
    }

    public func format(value: Decimal) -> String? {
        return format(value: value, includeSymbol: true)
    }
    
    public func format(value: Decimal, includeSymbol: Bool) -> String? {
        let formatter = self.currencyFormatter
        
        if !includeSymbol {
            formatter.currencySymbol = ""
        }
        
        if value == Decimal.nan {
            return formatter.string(from: 0)
        } else {
            return formatter.string(from: value as NSDecimalNumber)
        }
    }

    public func format(satoshis: Satoshi) -> String? {
        return format(satoshis: satoshis, includeSymbol: true)
    }
    
    public func format(satoshis: Satoshi, includeSymbol: Bool) -> String? {
        if !satoshis.isNormal {
            return format(value: 0, includeSymbol: includeSymbol)
        } else {
            let fiatValue = CurrencyConverter.convert(amount: satoshis, from: Bitcoin.satoshi, to: Bitcoin.bitcoin) * exchangeRate
            return format(value: fiatValue, includeSymbol: includeSymbol)
        }
    }

    public func decimal(from string: String) -> Decimal? {
        let numberFormatter = NumberFormatter()
        numberFormatter.generatesDecimalNumbers = true
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.locale = Locale.autoupdatingCurrent
        numberFormatter.numberStyle = .decimal

        return ((numberFormatter.number(from: string)) as? NSDecimalNumber)?.decimalValue
    }

    public func satoshis(from string: String) -> Satoshi? {
        guard let fiatValue = decimal(from: string) else { return nil }
        return satoshis(from: fiatValue)
    }

    public func satoshis(from fiatValue: Decimal) -> Satoshi {
        return CurrencyConverter.convert(amount: fiatValue, from: self, to: Bitcoin.satoshi)
    }

    public func value(satoshis: Satoshi) -> Decimal? {
        return CurrencyConverter.convert(amount: satoshis, from: Bitcoin.satoshi, to: self)
    }

    public func stringValue(satoshis: Satoshi) -> String? {
        guard let value = self.value(satoshis: satoshis) else { return nil }

        let valueFormatter = NumberFormatter()
        valueFormatter.maximumFractionDigits = 2
        valueFormatter.usesGroupingSeparator = false

        return valueFormatter.string(from: value as NSDecimalNumber)
    }
}
