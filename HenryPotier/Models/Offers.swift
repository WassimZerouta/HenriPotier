//
//  Offers.swift
//  HenryPotier
//
//  Created by Wassim on 13/02/2024.
//

import Foundation

struct Offers: Codable, Sequence {
    let offers: [Offer]
    
    func makeIterator() -> IndexingIterator<[Offer]> {
        return offers.makeIterator()
    }
}

struct Offer: Codable {
    let type: String
    let value: Int
    let sliceValue: Int?
}
