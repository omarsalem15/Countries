//
//  ViewController.swift
//  Countries
//
//  Created by Omar Salem on 15/03/2024.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet weak var countriesTblView: UITableView!
    
    private let countryViewModel = CountryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        
        countriesTblView.register(UINib(nibName: "CustomCountryCell", bundle: .main), forCellReuseIdentifier: "CountryCell")
        countriesTblView.dataSource = self
        countriesTblView.delegate = self
        
    }
    
    private func fetchData(){
        countryViewModel.fetchCountries { result in
            switch result{
            case.success(let countries):
                print(countries.count)
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

extension CountryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let countries = countryViewModel.allCountriesArr{
            print(countries.count)
            return countries.count
        }
        print("no count")
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTblView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CustomCountryCell
        
        //        print(countryViewModel.countries![10].population)
        
        if let country = countryViewModel.allCountriesArr?[indexPath.row]{
            cell.countryFlagLbl.text = country.flag
            cell.countryNameLbl.text = country.name.common
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

