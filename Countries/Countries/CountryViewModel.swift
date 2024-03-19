//
//  CountryViewModel.swift
//  Countries
//
//  Created by Omar Salem on 19/03/2024.
//

import Foundation

class CountryViewModel {
    
    private let networkService = NetworkService()
    
    var allCountriesArr: [Country]?
    
    var filteredCountriesArr: [Country]?
    
    func fetchCountries(completion:@escaping(Result<[Country], Error>) -> Void){
        networkService.request(Endpoint.listCountries) { (result: Result<[Country], Error>) in
            switch result{
            case.success(let countries):
                self.allCountriesArr = countries
                self.filteredCountriesArr = countries
            case .failure(let error):
                print(error)
            }
            completion(result)
        }
    }
    

    
    func searchByLanguageOrName(searchText: String, completion: @escaping (Result<[Country], Error>) -> Void) {
            if let language = Locale.current.localizedString(forIdentifier: searchText) { // Search by language
                let endpoint = Endpoint.languageSearch(language)
                networkService.request(endpoint) { [weak self] (result: Result<[Country], Error>) in
                    switch result {
                    case .success(let countries):
                        self?.filteredCountriesArr = countries
                        completion(.success(countries))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else { // Search by name
                let endpoint = Endpoint.nameSearch(searchText)
                networkService.request(endpoint) { [weak self] (result: Result<[Country], Error>) in
                    switch result {
                    case .success(let countries):
                        self?.filteredCountriesArr = countries
                        completion(.success(countries))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    

}
