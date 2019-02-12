//
//  CurrencyConverterTests.swift
//  SwiftBTC_Tests
//
//  Created by Otto Suess on 12.02.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftBTC
import XCTest

class CurrencyConverterTests: XCTestCase {
    func testXToSatoshi() {
        let data: [(Decimal, Bitcoin, Satoshi)] = [
            (0, .satoshi, 0),
            (1, .satoshi, 1),
            (123456, .satoshi, 123456),
            (1, .bit, 100),
            (1.678, .bit, 167.8),
            (-1.678, .bit, -167.8),
            (1, .milliBitcoin, 100000),
            (1, .bitcoin, 100000000)
        ]
        
        for (input, unit, satoshis) in data {
            XCTAssertEqual(CurrencyConverter.convert(amount: input, from: unit, to: Bitcoin.satoshi), satoshis)
        }
    }
    
    func testSatoshiToX() {
        let data: [(Bitcoin, Satoshi, Decimal)] = [
            (.bitcoin, 100_000_000, 1),
            (.bitcoin, 10_000_000, 0.1),
            (.bitcoin, 1_000_000, 0.01),
            (.bitcoin, 100_000, 0.001),
            (.bitcoin, 10_000, 0.0001),
            (.bitcoin, 1_000, 0.00001),
            (.bitcoin, 100, 0.000001),
            (.bitcoin, 10, 0.0000001),
            (.bitcoin, 1, 0.00000001),
            
            (.bit, 100_000_000, 1_000_000),
            (.bit, 10_000_000, 100_000),
            (.bit, 1_000_000, 10_000),
            (.bit, 100_000, 1_000),
            (.bit, 10_000, 100),
            (.bit, 1_000, 10),
            (.bit, 100, 1),
            (.bit, 10, 0.1),
            (.bit, 1, 0.01),
            
            (.satoshi, 100_000_000, 100_000_000),
            (.satoshi, 10_000_000, 10_000_000),
            (.satoshi, 1_000_000, 1_000_000),
            (.satoshi, 100_000, 100_000),
            (.satoshi, 10_000, 10_000),
            (.satoshi, 1_000, 1_000),
            (.satoshi, 100, 100),
            (.satoshi, 10, 10),
            (.satoshi, 1, 1)
        ]
        for (unit, satoshis, result) in data {
            XCTAssertEqual(CurrencyConverter.convert(amount: satoshis, from: Bitcoin.satoshi, to: unit), result, "(\(unit), \(satoshis) = \(result)))")
        }
    }
}
