//
//  HomeViewModel.swift
//  HenryPotier
//
//  Created by Wassim on 28/01/2024.
//

import Foundation
import RxSwift
import RxCocoa


class HomeViewModel {
    
    let books: PublishSubject<Books> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    
    func displayBook() {
        self.isLoading.onNext(true)

        APIManager().fetchBook { result in
            switch result {
            case .success(let books):
                self.isLoading.onNext(false)
                self.books.onNext(books)
                
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
