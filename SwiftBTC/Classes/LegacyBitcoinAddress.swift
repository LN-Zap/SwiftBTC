//
//  SwiftBTC
//
//  Created by Otto Suess on 28.02.18.
//  Copyright © 2018 Zap. All rights reserved.
//

import Foundation

struct LegacyBitcoinAddress {
    private enum AddressTypeVersion: Int {
        case pubkeyHash = 0
        case scriptHash = 5
        case privateKey = 128

        case testnetPubkeyHash = 111
        case testnetScriptHash = 196
        case testnetPrivateKey = 239

        case simnetPubkeyHash = 63
        case simnetScriptHash = 123
        case simnetPrivateKey = 100
    }

    enum AddressType {
        case pubkeyHash
        case scriptHash
        case privateKey
    }

    let string: String
    let network: Network
    let type: AddressType

    init?(string: String) {
        guard
            let (version, _) = Base58.checkDecode(string),
            let typeVersion = AddressTypeVersion(rawValue: version)
            else { return nil }

        self.string = string

        switch typeVersion {
        case .pubkeyHash:
            type = .pubkeyHash
            network = .mainnet
        case .scriptHash:
            type = .scriptHash
            network = .mainnet
        case .privateKey:
            type = .privateKey
            network = .mainnet
        case .testnetPubkeyHash:
            type = .pubkeyHash
            network = .testnet
        case .testnetScriptHash:
            type = .scriptHash
            network = .testnet
        case .testnetPrivateKey:
            type = .privateKey
            network = .testnet
        case .simnetPubkeyHash:
            type = .pubkeyHash
            network = .simnet
        case .simnetScriptHash:
            type = .scriptHash
            network = .simnet
        case .simnetPrivateKey:
            type = .privateKey
            network = .simnet
        }
    }
}
