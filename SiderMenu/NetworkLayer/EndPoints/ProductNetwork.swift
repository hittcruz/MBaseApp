//
//  ProductNetwork.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

enum ProductService: ServiceEnum {
    case list
    case filterProducts(categorieID: Int)
 
}

struct ProductNetworkFactory: Networking {

    typealias EnumType = ProductService
    static func getService(from type: EnumType) -> Requestable {
        switch type {
        case .list:
            return ProductList()
        case .filterProducts(categorieID: let categorieID):
            return FilterProducts(categorieID)
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
    
    private struct FilterProducts: Requestable{
        private var categorieId: Int
        
        var method: HTTPMethod = .post
        
        var path: String = "filterProducts"
        
        var parameters: [String : Any]{
            return [
                "categorie_id": categorieId
            ]
        }
        
        init(_ categorieId: Int){
            self.categorieId = categorieId
        }
    }
}
