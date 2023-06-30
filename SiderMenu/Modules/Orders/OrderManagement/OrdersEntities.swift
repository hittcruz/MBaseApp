//
//  OrdersEntities.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation

// MARK: - OrderModel
struct OrderModel: Codable {
    let id : Int?
    let userId : Int?
    let clientId: Int?
    let statusID: Int?
    let numberOrder: String?
    let orderDate: String?
    let client, state, deliveryDate: String?
    let count: String?
    let total, amount: Double?

    enum CodingKeys: String, CodingKey {
        case id, client, state, numberOrder
        case deliveryDate = "delivery_date"
        case orderDate = "order_date"
        case clientId = "client_id"
        case userId = "user_id"
        case statusID = "status_id"
        case count, total, amount
    }
}
