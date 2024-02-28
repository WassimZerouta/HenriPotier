//
//  Books.swift
//  HenryPotier
//
//  Created by Wassim on 26/01/2024.
//

import Foundation

struct Book: Codable {
    let isbn, title: String
    let price: Int
    let cover: String
    let synopsis: [String]
}

typealias Books = [Book]
