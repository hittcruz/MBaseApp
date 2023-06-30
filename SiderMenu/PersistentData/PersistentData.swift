//
//  PersistentData.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 30/06/23.
//

import Foundation

enum Keys: String {
   case nameClient
}

final class PersistentData {
    static let shared = PersistentData()
    
    var nameClient = Persistent<String>(Keys.nameClient.rawValue)
    
    init() {
        self.nameClient.value = ""
    }
}
