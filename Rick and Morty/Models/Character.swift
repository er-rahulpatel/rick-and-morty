//
//  Character.swift
//  Rick and Morty
//
//  Created by Applanding Solutions on 2022-12-13.
//

import Foundation

struct Character: Decodable  {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    private let location: [String:String]
    let image: String
    let episode: [String]
    var locationName: String {
        return location["name"] ?? ""
    }
}

struct Characters: Decodable {
    let results:[Character]?
}

