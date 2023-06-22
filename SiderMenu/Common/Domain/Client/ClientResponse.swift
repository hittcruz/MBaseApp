//
//  ClientResponse.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

// MARK: - ClientResponse
struct ClientResponse: Codable {
    let message: String
    let clients: [Client]?
}

// MARK: - Client
struct Client: Codable {
    let id: Int?
    let dni, ruc, name, email: String?
    let phone, address, district, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, dni, ruc, name, email, phone, address, district
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
