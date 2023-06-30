//
//  StatusResponse.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 26/06/23.
//

import Foundation

struct StatusModel: Codable {
    let stateID: Int?
    let state, code: String?
    let count: Int?

    enum CodingKeys: String, CodingKey {
        case stateID = "stateId"
        case state, count, code
    }
}
