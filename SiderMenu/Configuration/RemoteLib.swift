//
//  RemoteLib.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 11/05/23.
//

import Foundation

public class RemoteLib {
    public static let shared = RemoteLib()

    public let settingsManager = SettingsManager()
    
    public func setSaveCredentialLogin(username: String = "", password: String = "", saveCredentiales: Bool) {
        if !username.isEmpty {
            settingsManager.username = username
        }
        if !password.isEmpty {
            settingsManager.password = password
        }
         settingsManager.saveCredentiales = saveCredentiales
    }
}
