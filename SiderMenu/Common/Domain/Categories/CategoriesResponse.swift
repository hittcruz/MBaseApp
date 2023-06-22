//
//  CategoriesResponse.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 19/06/23.
//

import Foundation

// MARK: - CategorieResponse
struct CategorieResponse: Codable {
    let message: String
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let description, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
