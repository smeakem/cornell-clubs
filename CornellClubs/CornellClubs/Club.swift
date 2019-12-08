//
//  Club.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 11/19/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import Foundation

//class Club {
//    var id: Int!
//    var name: String!
//    var description: String!
//    var categories: [Category]!
//    var members: [Member]!
//    //GET RID OF ISFAVORITE
//    //var isFavorite: Bool!
//    //var categories: [String]!
//
//    init(name: String, description: String, categories: [Category], members: [Member]) {
//        self.name = name
//        self.description = description
//        //self.isFavorite = false
//        self.members = members
//        self.categories = categories
//    }
//}

struct Club: Codable {
        var id: Int
        var name: String
        var description: String
        var categories: [String]
        var members: [String]
}
