//
//  OrdersEntities.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation

struct OrderModel {
    let id : Int
    let user_id : Int
    let client_id: Int
    let numberOrder: String
    let order_date: String
    let delivery_date: String
    let amount: Double
    let state: String
}
