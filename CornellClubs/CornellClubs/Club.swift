//
//  Club.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 11/19/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import Foundation

class Club {
    var name: String!
    var description: String!
    //var categories: [String]!

    init(name: String, description: String, categories: [String]) {
        self.name = name
        self.description = description
        //self.categories = categories
    }
}
