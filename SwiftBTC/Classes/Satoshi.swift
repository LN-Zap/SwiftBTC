//
//  File.swift
//  BigInt
//
//  Created by Otto Suess on 22.02.19.
//

import Foundation

public typealias Satoshi = Decimal

public extension Satoshi {
    func rounded() -> Satoshi {
        var value = self
        var result: Decimal = 0
        NSDecimalRound(&result, &value, 0, .bankers)
        return result
    }

    var int64: Int64 {
        return Int64(truncating: self.rounded() as NSDecimalNumber)
    }
}
