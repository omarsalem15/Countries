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
        // Search by name
        let nameEndpoint = Endpoint.nameSearch(searchText)
        
        networkService.request(nameEndpoint) { [weak self] (nameResult: Result<[Country], Error>) in
            switch nameResult {
            case .success(let countries):
                self?.filteredCountriesArr = countries
                completion(.success(countries))
                print("\n====> Success: Found by name - \n")
                
            case .failure(let nameError):
                // If not found by name, search by language
                let languageEndpoint = Endpoint.languageSearch(searchText)
                
                self?.networkService.request(languageEndpoint) { [weak self] (languageResult: Result<[Country], Error>) in
                    
                    switch languageResult {
                    case .success(let countries):
                        self?.filteredCountriesArr = countries
                        completion(.success(countries))
                        print("\n====> Success: Found by language - \n")
                        
                    case .failure(let languageError):
                        completion(.failure(languageError))
                    }
                }
            }
        }
    }
}



