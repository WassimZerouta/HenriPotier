//
//  BookTableViewCell.swift
//  HenryPotier
//
//  Created by Wassim on 29/01/2024.
//

import UIKit
import Hero

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            if let cover = book?.cover {
                coverView.loadImage(from: cover)
            }
            
            titleLabel.text = book?.title
        }
    }

    var coverView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(coverView)
        contentView.addSubview(titleLabel)
        
        coverView.hero.id = "coverView"
        
        coverView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverView.widthAnchor.constraint(equalToConstant: 150),
            coverView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            coverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
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
