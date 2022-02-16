//
//  Prod Model.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//

import Foundation

struct ProductListDataProduct: Codable {
    var data: [ProductListData]
}

struct ProductListData: Codable {
    var id: Int
    var name: String
    var producer: String
    var product_images: String
    var description: String
    var cost: Int
    var rating: Int
}
