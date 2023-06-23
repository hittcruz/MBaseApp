//
//  OrderAddProductEntities.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import UIKit

struct OrderDetailModel {
    let id : Int
    let order_id: Int
    let product_id: Int
    let quantity: Int
    let sale_preci: Double
}

enum CategorieOption: String, CaseIterable{
    case accessorie = "Accesorios"
    case gas = "Combustibles"
    case water = "Líquidos"
    case textil = "Textil"
    
    var imageName: String {
        switch self {
        case .accessorie:
            return "icons8-mitones-100"
        case .gas:
            return "icons8-gas-bottle-100"
        case .water:
            return "icons8-agua-100"
        case .textil:
            return "icons8-mitones-100"
        }
    }
}

// MARK: - CartModel
struct CartModel: Codable {
    let message: String?
    let count: Int?
    let total: Double?
    let products: [Products]?
}

// MARK: - FilterModel
struct FilterModel: Codable {
    let message: String?
    let results: [Products]?
}
