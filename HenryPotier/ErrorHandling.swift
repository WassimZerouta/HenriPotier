//
//  ErrorHandling.swift
//  HenryPotier
//
//  Created by Wassim on 26/01/2024.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case dataNotFound
    case networkError(String)
    case wrongResponse
    case jsonDecodingError(String)
}
