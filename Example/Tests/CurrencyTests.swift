//
//  CurrencyTests.swift
//  SwiftBTC_Tests
//
//  Created by Otto Suess on 12.02.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftBTC
import XCTest

final class CurrencyTests: XCTestCase {
    private let usd = FiatCurrency(currencyCode: "USD", symbol: "$", localized: "US Dollar", exchangeRate: 7000.00)
    private let eur = FiatCurrency(currencyCode: "EUR", symbol: "€", localized: "Euro", exchangeRate: 5500.00)

    func testSatoshisToCurrency() {
        let data: [(Currency, Satoshi, String)] = [
            (usd, 100_000_000, "$7,000.00"),
            (usd, 50_000_000, "$3,500.00"),
            (eur, 100_000_000, "€5,500.00"),
            (eur, 1, "€0.00"),
            (Bitcoin.bitcoin, 100_000_000, "1.0 BTC"),
            (Bitcoin.satoshi, 1, "1 sat"),
            (Bitcoin.satoshi, 1234, "1,234 sat")
        ]

        for (currency, value, output) in data {
            XCTAssertEqual(currency.format(satoshis: value), output)
        }
    }

    func testFiatStringToSatoshis() {
        let data: [(FiatCurrency, String, Satoshi)] = [
            (usd, "7,000.00", 100_000_000),
            (usd, "7000.00", 100_000_000),
            (usd, "3,500.00", 50_000_000),
            (eur, "5,500.00", 100_000_000),
            (eur, "0.00", 0)
        ]

        for (currency, string, output) in data {
            XCTAssertEqual(currency.satoshis(from: string), output, "(currency code: \(currency.currencyCode), input: \(string), expected output: \(output))")
        }
    }
}
