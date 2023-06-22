//
//  ProductNetwork.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

enum ProductService: ServiceEnum {
    case list
 
}

struct ProductNetworkFactory: Networking {

    typealias EnumType = ProductService
    static func getService(from type: EnumType) -> Requestable {
        switch type {
        case .list:
            return ProductList()
        }
    }
}

extension ProductNetworkFactory {

    private struct ProductList: Requestable {
        
        var method: HTTPMethod = .get

        var path: String = "/showAddProducts"

        var parameters: [String: Any] {
            return [:]
        }

        init() {
            
        }
    }
}
