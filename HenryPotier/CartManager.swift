//
//  CartManager.swift
//  HenryPotier
//
//  Created by Wassim on 29/01/2024.
//

import Foundation

class CartManager {
    
    static let shared = CartManager()
    
    private init() {}
    
    var cart = Books()
    
    
    func cartAction(book: Book) -> Bool {
        if cart.contains(where: { $0.isbn == book.isbn }) {
            removeToCart(book: book)
            return false
        } else {
            addToCart(book: book)
            print(cart)
            return true
        }
    }
    
    
    func isBookInCart(book: Book) -> Bool {
        if cart.contains(where: { $0.isbn == book.isbn }) {
            return true
        } else {
            print(cart)
            return false
        }
    }
    
    
    func isbnConcat() -> String {
        guard !cart.isEmpty else { return "" }
        
        let isbns = cart
            .map { $0.isbn }
            .reduce(""){$0+$1}
        
        return isbns
        
    }
    
    
    //----------------- PRIVATE ----------------------\\
    
    private func addToCart(book: Book) {
        cart.append(book)
    }
    
    private func removeToCart(book: Book) {
        cart.removeAll { book in
            book.isbn == book.isbn
        }
    }
    
    
}
