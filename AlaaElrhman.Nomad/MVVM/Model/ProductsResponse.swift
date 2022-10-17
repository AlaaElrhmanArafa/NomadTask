//
//  ProductsResponse.swift
//  AlaaElrhman.Nomad
//
//  Created by AlaaElrhman on 15/10/2022.
//

import Foundation

typealias ProductsResponse = [String: Product]

struct Product: Codable {
    let barcode, productsResponseDescription, id: String?
    let imageURL: String?
    let name: String?
    let retailPrice, costPrice: Int?

    enum CodingKeys: String, CodingKey {
        case barcode
        case productsResponseDescription = "description"
        case id
        case imageURL = "image_url"
        case name
        case retailPrice = "retail_price"
        case costPrice = "cost_price"
    }
}
