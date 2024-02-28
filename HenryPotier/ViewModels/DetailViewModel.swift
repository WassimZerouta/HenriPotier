//
//  DetailViewModel.swift
//  HenryPotier
//
//  Created by Wassim on 29/01/2024.
//

import Foundation
import UIKit

class DetailViewModel {
    
    
    func cartAction(book: Book) -> Bool {
        return CartManager.shared.cartAction(book: book)
    }
    
    func isBookInCart(book: Book) -> Bool {
        return CartManager.shared.isBookInCart(book: book)
    }
}
