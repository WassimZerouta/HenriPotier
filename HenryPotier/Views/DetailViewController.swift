//
//  DetailViewController.swift
//  HenryPotier
//
//  Created by Wassim on 29/01/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?
    
    let detailViewModel = DetailViewModel()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coverView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let synopsisLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        let cartImage = UIImage(systemName: detailViewModel.isBookInCart(book: book!) ? "cart.fill.badge.minus" : "cart.fill.badge.plus")?.withTintColor(detailViewModel.isBookInCart(book: book!) ? .red : .systemMint, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: cartImage, style: .plain, target: self, action: #selector(cartAction))
        let backimage = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backimage, style: .plain, target: self, action: #selector(handleBack))
        scrollView.showsVerticalScrollIndicator = false
        displayBook()
        setUpConstraints()
    }
    
    @objc  func handleBack() {
        navigationController?.popViewController(animated: true)
    }
        
    @objc func cartAction() {
        guard let book = book else { return }
        if  detailViewModel.cartAction(book: book) {
            
            let newCartIcon = UIImage(systemName: "cart.fill.badge.minus")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            navigationItem.rightBarButtonItem?.image = newCartIcon
            
        } else {
            let newCartIcon = UIImage(systemName: "cart.fill.badge.plus")?.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
            navigationItem.rightBarButtonItem?.image = newCartIcon
        }
    }
    
    private func setUpConstraints() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(coverView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(synopsisLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

            coverView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            coverView.heightAnchor.constraint(equalToConstant: 250),
            coverView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: coverView.bottomAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            priceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),

            synopsisLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 15),
            synopsisLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            synopsisLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            synopsisLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
    
    private func displayBook() {
        guard let book = book else {return}
        coverView.loadImage(from: book.cover)
        titleLabel.text = book.title
        priceLabel.text = "Prix: \(book.price)$"
        let synopsisString = book.synopsis.joined(separator: "\n")
        synopsisLabel.text = synopsisString
    }
}
