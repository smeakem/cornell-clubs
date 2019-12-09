//
//  IndClubViewController.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 11/19/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import UIKit

protocol DeleteClubViewControllerDelegate: class {
    func willBeDismissed()
}

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
    
    var categories: UILabel!
    var categoriesText: String!
    var categoriesLabel: UILabel!
    
    var deleteButton: UIButton!
    
    var clubID: Int!
    
    weak var delegate: DeleteClubViewControllerDelegate?

    

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
        descriptionLabel.sizeToFit()
        descriptionLabel.adjustsFontSizeToFitWidth = true
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
        
        deleteButton = UIButton()
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.setTitle("Delete this Club", for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        view.addSubview(deleteButton)
        
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
        isFavorite = false
        isFavoriteText = "Favorite"
        clubID = club.id
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
            descriptionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            descriptionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: padding)
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
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: isFavoriteButton.bottomAnchor, constant: padding),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: padding)
        ])
        
    }
    
    @objc func favoriteButtonPressed() {
        if (isFavorite) {
            isFavorite = false
            //isFavoriteText = "Favorite"
            isFavoriteButton.setTitle("Favorite", for: .normal)
            isFavoriteImage.isHidden = true
            NetworkManager.unfavoriteClub(id: clubID) { (clubs) in
            }
        }
        else {
            isFavorite = true
            isFavoriteButton.setTitle("Unfavorite", for: .normal)
            isFavoriteImage.isHidden = false
            NetworkManager.favoriteClub(id: clubID) { (clubs) in
            }
        }
        
    }
    
    @objc func deleteButtonPressed() {
        NetworkManager.deleteClub(id: clubID, completion: { (club) in
            DispatchQueue.main.async {
                self.delegate?.willBeDismissed()
                self.dismiss(animated: true)
            }
        })
    }
    
}
