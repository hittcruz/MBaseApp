//
//  CategoryNetwork.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

enum CategoryService: ServiceEnum {
    case list
 
}

struct CategoryNetworkFactory: Networking {

    typealias EnumType = CategoryService
    static func getService(from type: EnumType) -> Requestable {
        switch type {
        case .list:
            return CategoryList()
        }
    }
}

extension CategoryNetworkFactory {

    private struct CategoryList: Requestable {
        
        var method: HTTPMethod = .get

        var path: String = "/categories"

        var parameters: [String: Any] {
            return [:]
        }

        init() {
            
        }
    }
}
