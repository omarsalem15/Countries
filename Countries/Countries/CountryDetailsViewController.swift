//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Omar Salem on 19/03/2024.
//

import UIKit
import SDWebImage

class CountryDetailsViewController: UIViewController {
    
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var countryPopulationLbl: UILabel!
    @IBOutlet weak var countryTimeZonesLbl: UILabel!
    @IBOutlet weak var countryCapitalLbl: UILabel!
    @IBOutlet weak var countryCurrencyLbl: UILabel!
    @IBOutlet weak var countryStartOfWeekLbl: UILabel!
    @IBOutlet weak var countryFlagImg: UIImageView!
    
    
    var selectedCountry: Country?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedCountry?.flag)
        
        
        // Do any additional setup after loading the view.
        
        if let country = selectedCountry {
            countryNameLbl.text = country.name.common
            countryPopulationLbl.text = "\(country.population)"
            countryTimeZonesLbl.text = "\(country.timezones.joined(separator: ", "))"
            if let safeCountryCapital = country.capital?.joined(separator: ", "){
                countryCapitalLbl.text = "\(safeCountryCapital)"
            }
            
            if let safeCountryCurrency = country.currencies?.keys.joined(separator: ", "){
                countryCurrencyLbl.text = "\(safeCountryCurrency)"
            }
                        
            countryStartOfWeekLbl.text = "\(country.startOfWeek)"
            
            let imageURL = URL(string:country.flags.png)
            countryFlagImg.sd_setImage(with: imageURL)
            
            
            print(country.currencies?.keys.joined(separator: ", "))
            
            
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
