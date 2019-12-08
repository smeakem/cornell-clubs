//
//  IndClubViewController.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 11/19/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import UIKit

class IndClubViewController: UIViewController {
    
    var nameLabel: UILabel!
    var nameText: String
    
    var descriptionLabel: UILabel!
    var descriptionText: String
    
    let padding: CGFloat = 10
    var isFavoriteText: String
    var isFavoriteButton: UIButton!
    var isFavorite: Bool
    var isFavoriteImage: UIImageView!
    
    let heartImageLength: CGFloat = 50
    
    let categories: UILabel!
    let categoriesText: String
    let categoriesLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nameLabel = UILabel()
        nameLabel.text = nameText
        nameLabel.textColor = .black
        nameLabel.font = nameLabel.font.withSize(30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = descriptionText
        descriptionLabel.textColor = .black
        descriptionLabel.font = descriptionLabel.font.withSize(20)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        isFavoriteButton = UIButton()
        isFavoriteButton.setTitle(isFavoriteText, for: .normal)
        isFavoriteButton.setTitleColor(.black, for: .normal)
        isFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        isFavoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        view.addSubview(isFavoriteButton)
        
        isFavoriteImage = UIImageView(image: UIImage(named: "heart"))
        isFavoriteImage.contentMode = .scaleAspectFit
        if (isFavorite) {
            isFavoriteImage.isHidden = false
        }
        else {
            isFavoriteImage.isHidden = true
        }
        isFavoriteImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(isFavoriteImage)
        
        setupConstraints()
    }
    
    init(club: Club) {
        nameText = club.name
        descriptionText = club.description
        if (club.isFavorite) {
            isFavorite = true
            isFavoriteText = "Unfavorite"
        }
        else {
            isFavorite = false
            isFavoriteText = "Favorite"
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            descriptionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding)
        ])
        NSLayoutConstraint.activate([
            isFavoriteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            isFavoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            isFavoriteImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            isFavoriteImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            isFavoriteImage.widthAnchor.constraint(equalToConstant: heartImageLength),
            isFavoriteImage.heightAnchor.constraint(equalToConstant: heartImageLength)
        ])
        
//            heartImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
//            heartImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
    }
    
    @objc func favoriteButtonPressed() {
        if (isFavorite) {
            isFavorite = false
            isFavoriteText = "Favorite"
            isFavoriteImage.isHidden = true
        }
        else {
            isFavorite = true
            isFavoriteText = "Unfavorite"
            isFavoriteImage.isHidden = false
        }
        
    }
    
}
