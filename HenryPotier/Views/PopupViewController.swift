//
//  PopupViewController.swift
//  HenryPotier
//
//  Created by Wassim on 13/02/2024.
//

import UIKit

class PopupViewController: UIViewController {
    
    let bestOffer: Int
    let total: Int
    let cart: Books
    let cellId = "cell"
    
    let mainView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
       let view = UITableView()
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 1
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    let bottomView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemMint
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thanksLabel: UILabel = {
        let label = UILabel()
        label.text = "Merci pour vos achats !"
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bestOfferLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(bestOffer: Int, cart: Books, total: Int) {
        self.bestOffer = bestOffer
        self.cart = cart
        self.total = total
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(blurEffectView)
        UIView.animate(withDuration: 5) {
            blurEffectView.effect = blurEffect
        }
        
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: cellId)
        
        bestOfferLabel.text = "Offre spéciale \(bestOffer.description)€ au lieu de \(total)€"
    }
    
   private func setupConstraints() {
       self.view.addSubview(mainView)
       mainView.addSubview(thanksLabel)
       mainView.addSubview(scrollView)
       mainView.addSubview(tableView)
       mainView.addSubview(bottomView)
       bottomView.addSubview(bestOfferLabel)
       
       NSLayoutConstraint.activate([
       mainView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
       mainView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
       mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
       mainView.heightAnchor.constraint(equalToConstant: 350),
       
       thanksLabel.topAnchor.constraint(equalTo: mainView.topAnchor),
       thanksLabel.heightAnchor.constraint(equalToConstant: 70),
       thanksLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
       
       scrollView.topAnchor.constraint(equalTo: thanksLabel.bottomAnchor),
       scrollView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
       scrollView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
       scrollView.rightAnchor.constraint(equalTo: mainView.rightAnchor),
       
       tableView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
       tableView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
       tableView.topAnchor.constraint(equalTo: scrollView.topAnchor),
       tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
       
       bottomView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
       bottomView.rightAnchor.constraint(equalTo: mainView.rightAnchor),
       bottomView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
       bottomView.heightAnchor.constraint(equalToConstant: 80),
       
       
       bestOfferLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
       bestOfferLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
       
       ])
        
    }

}

extension PopupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(cart.count)
        return cart.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CartTableViewCell
        cell.book = cart[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}
