//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Muhammad Ziddan Hidayatullah on 12/09/22.
//

import Foundation

struct CoinModel: Codable, Equatable {
    let currency: String
    let rate: Double
    
    private enum CodingKeys: String, CodingKey {
        case currency = "asset_id_quote"
        case rate = "rate"
    }
}
