//
//  CartViewModel.swift
//  HenryPotier
//
//  Created by Wassim on 12/02/2024.
//

import Foundation

import RxSwift

class CartViewModel {
    
    let cartSubject = BehaviorSubject<Books?>(value: nil)
    let offers: PublishSubject<Int> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    var totalPrice = Int()

    let disposeBag = DisposeBag()
    
    init() {
        observeCartChanges()
    }
    
    private func observeCartChanges() {
        CartManager.shared.cartSubject
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] cart in
                self?.cartSubject.onNext(cart)
            }
            .disposed(by: disposeBag)
    }

     func updatePrice() {
         let totalPrice = CartManager.shared.totalPrice()
         self.totalPrice = totalPrice
         print("oooooo \(totalPrice)")
         print("total price: \(totalPrice)")
         fetchOffers(total: totalPrice)
    }
    
    func fetchOffers(total:Int) {
        APIManager().fetchOffers(total: total) { result in
            switch result {
            case .success(let offers):
                self.offers.onNext(offers)
                print("offers: \(offers)")
            case .failure(let error):
                switch error {
                case .dataNotFound:
                    self.error.onNext("Data not found")
                case .invalidURL:
                    self.error.onNext("Invalid url")

                case .jsonDecodingError(let errorDescription):
                    self.error.onNext(errorDescription)

                case .networkError(let errorDescription):
                    self.error.onNext(errorDescription)
                case .wrongResponse:
                    self.error.onNext("Unknown error")
                }
                
            }
        }
    }
}
