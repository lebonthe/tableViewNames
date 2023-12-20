//
//  PlanetNames.swift
//  tableViewNames
//
//  Created by Min Hu on 2023/12/20.
//

import Foundation

struct PlanetNames: Decodable {
    let planetNames: [PlanetName]
}

struct PlanetName: Decodable {
    let name: String
}

