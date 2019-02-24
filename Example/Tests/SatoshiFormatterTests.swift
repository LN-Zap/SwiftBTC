//
//  SwiftBTC_Tests
//
//  Created by Otto Suess on 28.03.18.
//  Copyright © 2018 Zap. All rights reserved.
//

import SwiftBTC
import XCTest

final class SatoshiFormatterTests: XCTestCase {
    // swiftlint:disable:next large_tuple
    let inputs: [(Bitcoin, Satoshi, String)] = [
        (.satoshi, 1, "1"),
        (.satoshi, 100, "100"),
        (.satoshi, 1000, "1,000"),
        (.satoshi, 100000000, "100,000,000"),
        (.bit, 1, "0.01"),
        (.bit, 123, "1.23"),
        (.bit, 1234, "12.34"),
        (.bit, 123456789, "1,234,567.89"),
        (.milliBitcoin, 1, "0.00001"),
        (.milliBitcoin, 123, "0.00123"),
        (.milliBitcoin, 1234, "0.01234"),
        (.milliBitcoin, 100000, "1.0"),
        (.milliBitcoin, 123456789, "1,234.56789"),
        (.bitcoin, 1, "0.00000001"),
        (.bitcoin, 100, "0.000001"),
        (.bitcoin, 123456000, "1.23456"),
        (.bitcoin, 123456789, "1.23456789"),
        (.bitcoin, 100000000, "1.0"),
        (.bitcoin, 100000000000, "1,000.0"),
        (.bitcoin, 100000000008, "1,000.00000008")
    ]

    func testFormating() {
        for (unit, satoshis, string) in inputs {
            let formatter = SatoshiFormatter(unit: unit)
            formatter.includeCurrencySymbol = false
            XCTAssertEqual(formatter.string(from: satoshis), string)
        }
    }

    func testSatoshiParsing() {
        for (unit, satoshis, string) in inputs {
            let formatter = SatoshiFormatter(unit: unit)
            formatter.includeCurrencySymbol = false
            XCTAssertEqual(formatter.satoshis(from: string), satoshis, "(\(unit), \(satoshis), \(string))")
        }
    }

    func testMilliSatoshiParsing() {
        let msat: [(Bitcoin, Satoshi, String)] = [
            (.satoshi, 1.1, "1.1"),
            (.satoshi, 100.01, "100.01"),
            (.bit, 111.1, "1.111"),
            (.bit, 0.1, "0.0010"),
            (.milliBitcoin, 0.1, "0.000001"),
            (.milliBitcoin, 1.000001, "0.00001000001"),
            (.bitcoin, 1.9, "0.000000019"),
            (.bitcoin, 0.9, "0.000000009")
        ]

        for (unit, satoshis, string) in msat {
            let formatter = SatoshiFormatter(unit: unit)
            formatter.includeCurrencySymbol = false

            XCTAssertEqual(formatter.satoshis(from: string), satoshis, string)
        }
    }

    func testWithoutCommas() {
        let noCommas: [(Bitcoin, Satoshi, String)] = [
            (.satoshi, 1000, "1000"),
            (.bit, 123456789, "1234567.89"),
            (.milliBitcoin, 123456789, "1234.56789"),
            (.bitcoin, 100000000000, "1000.0"),
            (.bitcoin, 100000000008, "1000.00000008")
        ]

        for (unit, satoshis, string) in noCommas {
            let formatter = SatoshiFormatter(unit: unit)
            formatter.includeCurrencySymbol = false

            XCTAssertEqual(formatter.satoshis(from: string), satoshis)
        }
    }

    func testStringValue() {
        let inputs: [(Bitcoin, Satoshi, String)] = [
            (.satoshi, 1, "1"),
            (.satoshi, 100, "100"),
            (.satoshi, 1000, "1000"),
            (.satoshi, 100000000, "100000000"),
            (.bit, 1, "0.01"),
            (.bit, 123, "1.23"),
            (.bit, 1234, "12.34"),
            (.bit, 123456789, "1234567.89"),
            (.milliBitcoin, 1, "0.00001"),
            (.milliBitcoin, 123, "0.00123"),
            (.milliBitcoin, 1234, "0.01234"),
            (.milliBitcoin, 100000, "1"),
            (.milliBitcoin, 123456789, "1234.56789"),
            (.bitcoin, 1, "0.00000001"),
            (.bitcoin, 100, "0.000001"),
            (.bitcoin, 123456000, "1.23456"),
            (.bitcoin, 123456789, "1.23456789"),
            (.bitcoin, 100000000, "1"),
            (.bitcoin, 100000000000, "1000"),
            (.bitcoin, 100000000008, "1000.00000008")
        ]

        for (unit, satoshis, string) in inputs {
            let formatter = SatoshiFormatter(unit: unit)
            formatter.usesGroupingSeparator = false
            formatter.includeCurrencySymbol = false
            formatter.minimumFractionDigits = 0
            XCTAssertEqual(formatter.string(from: satoshis), string)
        }
    }
}
