//
//  HomeViewController.swift
//  HenryPotier
//
//  Created by Wassim on 26/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UIScrollViewDelegate {

    let homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    let tableView: UITableView = UITableView()
    let cellId = "cellId"
    
    var books = Books()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: cellId)
        setUptableViewConstraints()
        setUpBindings()
        homeViewModel.displayBook()
    }
    
    private func setUpBindings() {
        
        homeViewModel.books
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { books in
                self.books = books
            }
            .disposed(by: disposeBag)
        
        homeViewModel.error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        homeViewModel.books
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: BookTableViewCell.self)) {row,book,cell in
                cell.book = book
            }
            .disposed(by: disposeBag)

    }
    
    private func setUptableViewConstraints() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        
        ])
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController(book: self.books[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
}

