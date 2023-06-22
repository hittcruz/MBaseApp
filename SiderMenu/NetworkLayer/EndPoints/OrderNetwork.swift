//
//  OrderNetwork.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 22/06/23.
//

import Foundation

enum OrderService: ServiceEnum {
    case addProduct(orderID: Int, productID: Int, quantity: Int, salePreci: Double)
    case removeAllProduct(orderID: Int)
    case showCart(orderID: Int)
 
}

struct OrderNetworkFactory: Networking {

    typealias EnumType = OrderService
    static func getService(from type: EnumType) -> Requestable {
        switch type {
        case .addProduct(let orderID, let productID, let quantity, let salePreci):
            return AddProduct(orderID, productID, quantity, salePreci)
        case .removeAllProduct(orderID: let orderID):
            return RemoveAllProduct(orderID)
        case .showCart(orderID: let orderID):
            return ShowCart(orderID)
        }
    }
}

extension OrderNetworkFactory {

    private struct AddProduct: Requestable {
        
        private var orderId: Int
        private var productId: Int
        private var quantity: Int
        private var salePreci: Double

        var method: HTTPMethod = .post

        var path: String = "addProducts"

        var parameters: [String: Any] {
            return [
                "order_id": orderId,
                "product_id": productId,
                "quantity": quantity,
                "sale_preci": salePreci
            ]
        }

        init(_ orderID: Int,_ productID: Int,_ quantity: Int,_ salePreci: Double) {
            self.orderId = orderID
            self.productId = productID
            self.quantity = quantity
            self.salePreci = salePreci
        }
    }
    
    private struct RemoveAllProduct: Requestable {
        
        private var orderId: Int
        
        var method: HTTPMethod = .delete
    
        var path: String = "removeAllProduct"
        
        var parameters: [String : Any] {
            return [
                "order_id": orderId
            ]
        }
        
        init(_ orderID: Int) {
            self.orderId = orderID
        }
    }
    
    private struct ShowCart: Requestable {
        
        private var orderId: Int
        
        var method: HTTPMethod = .post
    
        var path: String = "showCart"
        
        var parameters: [String : Any] {
            return [
                "order_id": orderId
            ]
        }
        
        init(_ orderID: Int) {
            self.orderId = orderID
        }
    }
}
