//
//  ClientNetwork.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

enum ClientService: ServiceEnum {
    case list
 
}

struct ClientNetworkFactory: Networking {

    typealias EnumType = ClientService
    static func getService(from type: EnumType) -> Requestable {
        switch type {
        case .list:
            return ClientList()
        }
    }
}

extension ClientNetworkFactory {

    private struct ClientList: Requestable {
        
        var method: HTTPMethod = .get

        var path: String = "/clients"

        var parameters: [String: Any] {
            return [:]
        }

        init() {
            
        }
    }
}
