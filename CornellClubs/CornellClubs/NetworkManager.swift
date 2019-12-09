//
//  NetworkManager.swift
//  CornellClubs
//
//  Created by Calli Sabaitis on 12/6/19.
//  Copyright © 2019 Calli Sabaitis. All rights reserved.
//

import Foundation
import Alamofire

enum ExampleDataResponse<T: Any> {
    case success(data: T)
    case failure(error: Error)
}

struct APIResponse<T: Codable>: Codable {
    let success: Bool
    let data: T
}

let endpointGetClubs = "http://35.227.43.197/api/clubs/"
let endpointCreateClub = "http://35.227.43.197/api/clubs"
let endpointFavoriteClub1 = "http://35.227.43.197/api/club/"
let endpointFavoriteClub2 = "/favorite/1/"
let endpointUnfavoriteClub1 = "http://35.227.43.197/api/club/"
let endpointUnfavoriteClub2 = "/unfavorite/1/"

class NetworkManager {
    
    static func getClubs(completion: @escaping ([Club]) -> Void) {
        Alamofire.request(endpointGetClubs, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let clubData = try? jsonDecoder.decode(APIResponse<[Club]>.self, from: data) {
                    let clubs = clubData.data
                    completion(clubs)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createClub(name: String, description: String, completion: @escaping ([Club]) -> Void) {
        let parameters = ["name": name, "description": description]
        Alamofire.request(endpointCreateClub, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData {response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let clubData = try? jsonDecoder.decode(APIResponse<[Club]>.self, from: data) {
                    let clubs = clubData.data
                    completion(clubs)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func favoriteClub(id: Int, completion: @escaping ([Club]) -> Void) {
        let newEndpoint = endpointFavoriteClub1 + String(id) + endpointFavoriteClub2
        Alamofire.request(newEndpoint, method: .post).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let clubData = try? jsonDecoder.decode(APIResponse<[Club]>.self, from: data) {
                    let clubs = clubData.data
                    completion(clubs)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func unfavoriteClub(id: Int, completion: @escaping ([Club]) -> Void) {
        let newEndpoint = endpointUnfavoriteClub1 + String(id) + endpointUnfavoriteClub2
        Alamofire.request(newEndpoint, method: .post).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let clubData = try? jsonDecoder.decode(APIResponse<[Club]>.self, from: data) {
                    let clubs = clubData.data
                    completion(clubs)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
