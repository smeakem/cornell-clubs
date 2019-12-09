//
//  AddClubViewController.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 12/8/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import UIKit

protocol AddClubViewControllerDelegate: class {
    func willBeDismissed()
}

class AddClubViewController: UIViewController {
    
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var descriptionLabel: UILabel!
    var descriptionTextField: UITextField!
    var addButton: UIButton!
    weak var delegate: AddClubViewControllerDelegate?
    
    let padding: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nameLabel = UILabel()
        nameLabel.text = "Name of Club: "
        nameLabel.textColor = .black
        nameLabel.font = nameLabel.font.withSize(20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description of Club: "
        descriptionLabel.textColor = .black
        descriptionLabel.font = nameLabel.font.withSize(20)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        nameTextField = UITextField()
        nameTextField.textColor = .black
        nameTextField.text = "ENTER NAME"
        nameTextField.clearsOnBeginEditing = true
        nameTextField.font = nameLabel.font.withSize(20)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        descriptionTextField = UITextField()
        descriptionTextField.text = "ENTER DESCRIPTION"
        descriptionTextField.clearsOnBeginEditing = true
        descriptionTextField.textColor = .black
        descriptionTextField.font = nameLabel.font.withSize(20)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextField)
        
        addButton = UIButton()
        addButton.setTitle("Add Club", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        view.addSubview(addButton)
        
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            descriptionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: padding),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func addButtonPressed() {
        NetworkManager.createClub(name: nameTextField.text!, description: descriptionTextField.text!, completion: { (club) in
            self.delegate?.willBeDismissed()
            self.dismiss(animated: true)
        })
    }
}
