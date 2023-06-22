//
//  CharacterNetwork.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

enum CharacterService: ServiceEnum {
    case list
 
}

struct CharacterNetworkFactory: Networking {

    typealias EnumType = CharacterService
    static func getService(from type: EnumType) -> Requestable {
        switch type {
        case .list:
            return CharacterList()
        }
    }
}

extension CharacterNetworkFactory {

    private struct CharacterList: Requestable {
        
        var method: HTTPMethod = .get

        var path: String = "/character"

        var parameters: [String: Any] {
            return [:]
        }

        init() {
            
        }
    }
}
