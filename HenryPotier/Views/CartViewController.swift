//
//  CartViewController.swift
//  HenryPotier
//
//  Created by Wassim on 26/01/2024.
//

import UIKit
import RxSwift

class CartViewController: UIViewController {
    let cartViewModel = CartViewModel()
    var cart = Books()
    let disposeBag = DisposeBag()
    var offer = Int()
    let tableView: UITableView = UITableView()
    let cellId = "cellId"
    
    let emptyCartlabel: UILabel = {
        let label = UILabel()
        label.text = "Vous n'avez aucun livre dans votre panier !"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Panier"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: cellId)
        setUptableViewConstraints()
    }
    

    
   @objc func paidButtonPressed() {
       cartViewModel.updatePrice()
       
       cartViewModel.offers
           .observe(on: MainScheduler.asyncInstance)
           .subscribe { offers in
               self.offer = offers
               let totalPrice = self.cartViewModel.totalPrice
               
               let nextVC = PopupViewController(bestOffer: self.offer, cart: self.cart, total:totalPrice)
               nextVC.view.backgroundColor = UIColor.clear
               self.present(nextVC, animated: true)
           }
           .disposed(by: disposeBag)
           
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartViewModel.cartSubject
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] cart in
                        self?.cart = cart ?? []
                    }
                    .disposed(by: disposeBag)
        
        if cart.isEmpty {
            emptyCartlabel.isHidden = false
            navigationItem.rightBarButtonItem?.isHidden = true
            

        } else {
            emptyCartlabel.isHidden = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Payer", style: .plain, target: self, action: #selector(paidButtonPressed))
        }
        tableView.reloadData()

    }
    
    private func setUptableViewConstraints() {
        self.view.addSubview(tableView)
        self.view.addSubview(emptyCartlabel)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            
            emptyCartlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartlabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! BookTableViewCell
        cell.book = cart[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController(book: self.cart[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: false)
        
    }
}
