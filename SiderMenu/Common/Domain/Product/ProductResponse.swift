//
//  ProductResponse.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 19/06/23.
//

import Foundation

// MARK: - Welcome
struct ProductResponse: Codable {
    let message: String
    let products: [Products]?
    let populars: [Products]?
}

// MARK: - Popular
struct Products: Codable {
    let id, categorieID: Int?
    let code, name, description: String?
    let stock: Int?
    let unitPreci: Double?
    let createdAt, updatedAt: String?
    let populars: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categorieID = "categorie_id"
        case code, name, description, stock
        case unitPreci = "unit_preci"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case populars
    }
}
