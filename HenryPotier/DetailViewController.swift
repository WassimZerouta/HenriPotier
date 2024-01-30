//
//  DetailViewController.swift
//  HenryPotier
//
//  Created by Wassim on 29/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Hero

class DetailViewController: UIViewController {
    
    var book: Book?
    
    let detailViewModel = DetailViewModel()
    let disposeBag = DisposeBag()
    
    let coverView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .green
        return label
    }()
    
    let synopsisLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    
    init(book: Book? = nil) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cartImage = UIImage(systemName: detailViewModel.isBookInCart(book: book!) ? "cart.fill.badge.minus" : "cart.fill.badge.plus"  )
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: cartImage, style: .plain, target: self, action: #selector(cartAction))

        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCoverView()
    }
    
    @objc func cartAction() {
        guard let book = book else { return }
        if  detailViewModel.cartAction(book: book) {
            
            let newCartIcon = UIImage(systemName: "cart.fill.badge.minus")
            navigationItem.rightBarButtonItem?.image = newCartIcon
            
        } else {
            let newCartIcon = UIImage(systemName: "cart.fill.badge.plus")
            navigationItem.rightBarButtonItem?.image = newCartIcon
        }
    }
    
    private func setUpConstraints() {
        self.view.addSubview(coverView)
        coverView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            coverView.heightAnchor.constraint(equalToConstant: 250),
            coverView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            coverView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
        
    }
    
    private func loadCoverView() {
        guard let book = book else {return}
        coverView.loadImage(from: book.cover)
        self.hero.isEnabled = true
        coverView.hero.id = "coverView"
    }
}
