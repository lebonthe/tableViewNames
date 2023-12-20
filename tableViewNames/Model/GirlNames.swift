//
//  GirlNames.swift
//  tableViewNames
//
//  Created by Min Hu on 2023/12/20.
//

import Foundation

struct GirlNames: Decodable {
    let names: [Names]
}

struct Names: Decodable {
    let firstName: String
    let lastName: String
}
