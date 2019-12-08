//
//  User.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 12/6/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import Foundation

class User {
    var favorites: [Club]!
    
    init(favorites: [Club]) {
        self.favorites = favorites
    }
}
