//
//  OrderNetwork.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 22/06/23.
//

import Foundation

enum OrderService: ServiceEnum {
    case list
    case addProduct(orderID: Int, productID: Int, quantity: Int, salePreci: Double)
    case removeAllProduct(orderID: Int)
    case showCart(orderID: Int)
    case filterOrder(statusID: Int, fromDate: String, toDate: String)
    case createOrder(userID: Int, clientID: Int, orderDate: String, deliveryDate:String, statusID: Int)
 
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
        case .list:
            return OrdersList()
        case .filterOrder(statusID: let statusID, fromDate: let fromDate, toDate: let toDate):
            return FilterOrders(statusID, fromDate, toDate)
        case .createOrder(userID: let userID, clientID: let clientID, orderDate: let orderDate, deliveryDate: let deliveryDate, statusID: let statusID):
            return CreateOrder(userID: userID, clientID: clientID, orderDate: orderDate, deliveryDate: deliveryDate, statusID: statusID)
        }
    }
}

extension OrderNetworkFactory {
    
    private struct OrdersList: Requestable {
        
        var method: HTTPMethod = .get

        var path: String = "/orders"

        var parameters: [String: Any] {
            return [:]
        }

        init() {
            
        }
    }

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
    
    private struct FilterOrders: Requestable{
        private var statusId: Int
        private var fromDate: String
        private var toDate: String
        
        var method: HTTPMethod = .post
        
        var path: String = "filterOrders"
        
        var parameters: [String : Any]{
            return [
                "status_id": statusId,
                "fromDate": fromDate,
                "toDate": toDate
            ]
        }
        
        init(_ statusId: Int, _ fromDate:String,_ toDate: String){
            self.statusId = statusId
            self.fromDate = fromDate
            self.toDate = toDate
        }
    }
    
    private struct CreateOrder: Requestable{
        private var userId: Int
        private var clientId: Int
        private var statusId: Int
        private var orderDate: String
        private var deliveryDate: String
        private var amount: Double
        
        var method: HTTPMethod = .post
        
        var path: String = "orders"
        
        var parameters: [String : Any]{
            return [
                "user_id" : userId,
                "client_id" : clientId,
                "order_date" : orderDate,
                "delivery_date" : deliveryDate,
                "amount" : amount,
                "status_id" : statusId
            ]
        }
        
        init(userID: Int, clientID: Int, orderDate: String, deliveryDate:String, statusID: Int){
            self.userId = userID
            self.clientId = clientID
            self.orderDate = orderDate
            self.deliveryDate = deliveryDate
            self.statusId = statusID
            self.amount = 0.85
        }
    }
}
