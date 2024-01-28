//
//  HomeViewController.swift
//  HenryPotier
//
//  Created by Wassim on 26/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    let homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    var books = Books()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        setUpBindings()
        homeViewModel.displayBook()
    }
    
    private func setUpBindings() {
        homeViewModel.books
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { books in
                self.books = books
                print(books)
                print("okok")
            }
            .disposed(by: disposeBag)
        
        homeViewModel.error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }

}
