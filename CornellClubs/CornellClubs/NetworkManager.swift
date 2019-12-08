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

let endpoint = "http://35.227.43.197/api/clubs/"

class NetworkManager {
    static func getClubs(completion: @escaping ([Club]) -> Void) {
        Alamofire.request(endpoint, method: .get).validate().responseData { (response) in
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
