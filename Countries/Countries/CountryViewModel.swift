//
//  CountryViewModel.swift
//  Countries
//
//  Created by Omar Salem on 19/03/2024.
//

import Foundation

class CountryViewModel {
    
    private let networkService = NetworkService()
    
    var allCountriesArr : [Country]?
    
    func fetchCountries(completion:@escaping(Result<[Country], Error>) -> Void){
        networkService.request(Endpoint.listCountries) { (result: Result<[Country], Error>) in
            switch result{
            case.success(let countries):
                self.allCountriesArr = countries
//                print(countries[150].population)
            case .failure(let error):
                print(error)
            }
            completion(result)
        }
    }
    
    func searchByLanguage(language:String,completion:@escaping(Result<[Country], Error>) -> Void){
        let endpoint = Endpoint.languageSearch(language)
        networkService.request(endpoint) { (result:Result<[Country],Error>) in
            completion(result)
        }
    }
    
    
    func searchByName(name:String,completion:@escaping(Result<[Country], Error>) -> Void){
        let endpoint = Endpoint.nameSearch(name)
        networkService.request(endpoint) { (result:Result<[Country],Error>) in
            completion(result)
        }
    }
}
