//
//  ViewController.swift
//  Countries
//
//  Created by Omar Salem on 15/03/2024.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet weak var countriesTblView: UITableView!
    
    @IBOutlet weak var searchTxtField: UITextField!
    private let countryViewModel = CountryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        
        title = "Countries"
        
        countriesTblView.register(UINib(nibName: "CustomCountryCell", bundle: .main), forCellReuseIdentifier: "CountryCell")
        countriesTblView.dataSource = self
        countriesTblView.delegate = self
        searchTxtField.delegate = self
        
    }
    
    
    private func fetchData(){
        countryViewModel.fetchCountries { result in
            switch result{
            case.success(let countries):
                DispatchQueue.main.async {
                    self.countriesTblView.reloadData()
                }
            case .failure(let error):
                print("\n\n\n2- error from View ==========================>\n\n\n")
                print(error)
            }
        }
    }
    
    
}

extension CountryViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let searchText = textField.text else { return }
        
        if !searchText.isEmpty {
            countryViewModel.searchByLanguageOrName(searchText: searchText) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let countries):
                    self.countryViewModel.filteredCountriesArr = countries
                    DispatchQueue.main.async {
                        self.countriesTblView.reloadData()
                    }
                case .failure(let error): break
                    //                       print("Search failed: \(error)")
                }
            }
        } else {
            countryViewModel.filteredCountriesArr = countryViewModel.allCountriesArr
            countriesTblView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
}

extension CountryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let countries = countryViewModel.filteredCountriesArr{
            print("countries count -> \(countries.count)")
            return countries.count
        }
        print("no count")
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTblView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CustomCountryCell
        
        if let country = countryViewModel.filteredCountriesArr?[indexPath.row]{
            cell.countryFlagLbl.text = country.flag
            cell.countryNameLbl.text = country.name.common
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected country indexpath -> \(indexPath)")
        
        if let selectedCountryCell = countryViewModel.filteredCountriesArr?[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let countryDetailsVC = storyboard.instantiateViewController(withIdentifier: "CountryDetailsViewController") as? CountryDetailsViewController {
                countryDetailsVC.selectedCountry = selectedCountryCell
                navigationController?.pushViewController(countryDetailsVC, animated: true)
            }
        }
        
    }
    
}

