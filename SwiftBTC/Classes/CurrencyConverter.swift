//
//  SatoshiConverter.swift
//  BigInt
//
//  Created by Otto Suess on 08.02.19.
//

import Foundation

public enum CurrencyConverter {
    public static func convert(amount: Decimal, from fromCurrency: Currency, to toCurrency: Currency) -> Decimal {
        return amount / fromCurrency.exchangeRate * toCurrency.exchangeRate
    }
}
