//
//  BooksService.swift
//  HenryPotier
//
//  Created by Wassim on 26/01/2024.
//

import Foundation

protocol BooksServices {
    func fetchBook(completion: @escaping (Result<Books, CustomError>) -> Void)
}
