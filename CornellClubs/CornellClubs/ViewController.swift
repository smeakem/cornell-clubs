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
    
    let padding: CGFloat = 10
    
    var clubs: [Club]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cornell Clubs"
        view.backgroundColor = .white
        
//        let club1 = Club(name: "Club 1", description: "description of club 1fxghgkhlgsdhfjgkuhlgjfhgsdhfjgkhjhkgjfhdfjgkhlikujyhtdgrshdtjrytkuyilkutjryhtergtrjtukyiutjrhtgrsdhjtkuyil", categories: ["category 1", "category 2", "category 3"])
//        let club2 = Club(name: "Club 2", description: "description of club 2", categories: ["category 1", "category 2", "category 3"])
//        let club3 = Club(name: "Club 3", description: "description of club 3", categories: ["category 1", "category 2", "category 3"])
        
        
        
        
        //clubs = [club1, club2, club3]
        
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
        
        setupContraints()
        getClubs()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            clubCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            clubCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            clubCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            clubCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func getClubs () {
        NetworkManager.getClubs()
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
        present(viewController, animated: true, completion: nil)
    }
}
