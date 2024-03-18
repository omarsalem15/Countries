//
//  Model.swift
//  Countries
//
//  Created by Omar Salem on 15/03/2024.
//

import Foundation

struct Country:Codable{
    let name: Name
    let currencies: [String: Currency]
    let capital: [String]
    let region: String
    let languages: [String:String]
    let population: Int
    let timezones: [String]
    let flags: Flags
    let startOfWeek: String
}

struct Name:Codable{
    let common : String
}

struct Currency:Codable{
    let name: String
    let symbol: String
}

struct Flags:Codable{
    let png: String
}
