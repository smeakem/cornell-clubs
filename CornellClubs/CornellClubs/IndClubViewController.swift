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
        
        setupConstraints()
    }
    
    init(club: Club) {
        nameText = club.name
        descriptionText = club.description
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
        
    }
    
}
