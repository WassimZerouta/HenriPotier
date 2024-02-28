//
//  CartManager.swift
//  HenryPotier
//
//  Created by Wassim on 29/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

class CartManager {
    
    static let shared = CartManager()
    
    private init() {}
    
     let cartSubject = BehaviorSubject<Books>(value: [])
    
    
    var cart: Books {
        do {
            return try cartSubject.value()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func cartAction(book: Book) -> Bool {
        if cart.contains(where: { $0.isbn == book.isbn }) {
            removeToCart(book: book)
            return false
        } else {
            addToCart(book: book)
            return true
        }
    }
    
    func isBookInCart(book: Book) -> Bool {
        return cart.contains(where: { $0.isbn == book.isbn })
    }
    
    func isbnConcat() -> String {
        return cart.map { $0.isbn }.joined()
    }
    
    func totalPrice() -> Int {
        let totalPrice = cart.reduce(0) { $0 + $1.price }
        return totalPrice
    }
    
    //----------------- PRIVATE ----------------------\\
    
    private func addToCart(book: Book) {
        var currentCart = cart
        currentCart.append(book)
        cartSubject.onNext(currentCart)
    }
    
    private func removeToCart(book: Book) {
        var currentCart = cart
        currentCart.removeAll { $0.isbn == book.isbn }
        cartSubject.onNext(currentCart)
    }
    
}
