//
//  OrderResponse.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 23/06/23.
//

import Foundation

// MARK: - Welcome
struct OrdersResponse: Codable {
    let message: String?
    let orders: [OrderModel]
    let status: [StatusModel]
}

