//
//  ServiceProtocols.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

protocol ServiceEnum {}

protocol Networking {
    associatedtype EnumType: ServiceEnum
    static func getService(from type: EnumType) -> Requestable
}
