//
//  ClubCollectionViewCell.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 11/19/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import UIKit

class ClubCollectionViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var categoriesLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byClipping //use somewhere else 
        contentView.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    func configure(for club: Club) {
        nameLabel.text = club.name
        descriptionLabel.text = club.description
    }
    
}
