//
//  BookTableViewCell.swift
//  HenryPotier
//
//  Created by Wassim on 29/01/2024.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    let detailViewModel = DetailViewModel()
    
    var book: Book? {
        didSet {
            if let cover = book?.cover {
                coverView.loadImage(from: cover)
            }
            titleLabel.text = book?.title
            
            let cartImage = UIImage(systemName: detailViewModel.isBookInCart(book: book!) ? "largecircle.fill.circle" : "")?.withTintColor(detailViewModel.isBookInCart(book: book!) ? .systemMint : .systemMint, renderingMode: .alwaysOriginal)
            cartIcon.image = cartImage
        }
    }

    var coverView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var cartIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coverView)
        contentView.addSubview(cartIcon)
        contentView.addSubview(titleLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverView.widthAnchor.constraint(equalToConstant: 150),
            coverView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            coverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cartIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            cartIcon.widthAnchor.constraint(equalToConstant: 20),
            cartIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: coverView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverView.image = nil
        titleLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
