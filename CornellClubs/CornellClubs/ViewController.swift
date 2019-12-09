//
//  ViewController.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 11/19/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var clubCollectionView: UICollectionView!
    let clubCellReuseIdentifier = "clubCellReuseIdentifier"
    
    var addNewButton: UIButton!
    
    let padding: CGFloat = 10
    
    var clubs: [Club] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cornell Clubs"
        view.backgroundColor = .white
        
        //set up club layout for menu collection view
        let clubLayout = UICollectionViewFlowLayout()
        clubLayout.scrollDirection = .vertical
        clubLayout.minimumLineSpacing = padding
        clubLayout.minimumInteritemSpacing = padding
        
        //set up clubs collection view
        clubCollectionView = UICollectionView(frame: .zero, collectionViewLayout: clubLayout)
        clubCollectionView.translatesAutoresizingMaskIntoConstraints = false
        clubCollectionView.backgroundColor = .white
        clubCollectionView.register(ClubCollectionViewCell.self, forCellWithReuseIdentifier: clubCellReuseIdentifier)
        clubCollectionView.dataSource = self
        clubCollectionView.delegate = self
        view.addSubview(clubCollectionView)
        
        //initialize button
        addNewButton = UIButton()
        addNewButton.setTitle("Add New Club", for: .normal)
        addNewButton.setTitleColor(.black, for: .normal)
        addNewButton.translatesAutoresizingMaskIntoConstraints = false
        addNewButton.addTarget(self, action: #selector(addButton), for: .touchUpInside)
        view.addSubview(addNewButton)
        
        setupContraints()
        getClubs()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            clubCollectionView.topAnchor.constraint(equalTo: addNewButton.bottomAnchor, constant: padding*2),
            clubCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            clubCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            clubCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        NSLayoutConstraint.activate([
            addNewButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            addNewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            addNewButton.heightAnchor.constraint(equalToConstant: 35),
            addNewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: padding)
        ])
    }
    
    func getClubs () {
        NetworkManager.getClubs { (clubs) in
            self.clubs = clubs
            DispatchQueue.main.async {
                self.clubCollectionView.reloadData()
            }
            
        }
    }
    
    @objc func addButton() {
        let viewContrtoller = AddClubViewController()
        viewContrtoller.delegate = self
        present(viewContrtoller, animated: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clubCollectionView.dequeueReusableCell(withReuseIdentifier: clubCellReuseIdentifier, for: indexPath) as! ClubCollectionViewCell
        cell.configure(for: clubs[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clubs.count
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (clubCollectionView.frame.width - padding)/2.0
        return CGSize(width: size, height: size)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let club = clubs[indexPath.row]
        let viewController = IndClubViewController(club: club)
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
}

extension ViewController: AddClubViewControllerDelegate, DeleteClubViewControllerDelegate {
    
    func willBeDismissed() {
        getClubs()
    }
    
}
