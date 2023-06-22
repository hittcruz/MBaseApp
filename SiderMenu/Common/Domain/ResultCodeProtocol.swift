//
//  ResultCodeProtocol.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

public protocol ResultCode {
    var resultCode: String? { get set }
    var resultDescription: String? { get set }
}
