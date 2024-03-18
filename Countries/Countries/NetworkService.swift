//
//  NetworkService.swift
//  Countries
//
//  Created by Omar Salem on 15/03/2024.
//

import Foundation
import Alamofire

class NetworkService{
    
    func request<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint.url, method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

enum Endpoint {
    case listCountries
    case nameSearch(String)
    case languageSearch(String)
    
    var baseURL: String {
        return "https://restcountries.com/v3.1"
    }
    
    var path: String {
        switch self {
        case .listCountries:
            return "/all"
            
        case .nameSearch(let name):
            return "/name/\(name)"
            
        case.languageSearch (let language):
            return "/lang/\(language)"
        }
    }
    
    var url: URL {
        return URL(string: baseURL + path)!
    }
    
    
}




