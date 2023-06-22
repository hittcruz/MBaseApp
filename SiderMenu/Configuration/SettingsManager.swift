//
//  SettingManager.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 11/05/23.
//

import Foundation

public class SettingsManager {
    
    //save login
    public let KEY_USERNAME = "KEY_USERNAME"
    public let KEY_PASSWORD = "KEY_PASSWORD"
    public let KEY_SAVE_CREDENTIALS = "KEY_SAVE_CREDENTIALS"
    
    init() {
                
        UserDefaults.standard.register(defaults: [:
//            KEY_API_ENDPOINT: "",
//            KEY_URL_ROOM_SERVER: "",
//            KEY_URL_STUN: "",
//            KEY_URL_VIDEO_NM: "",
//            KEY_FIREBASE_TOKEN: "",
//            KEY_ENTITY_SELECTED: false,
//            KEY_HOME_ENABLE: true,
//            KEY_HOME_TITLE: "",
//            KEY_HOME_MESSAGE: "",
//            KEY_ENTITY_CODE: "",
//            KEY_ENTITY_NAME: "",
//            KEY_ENTITY_LOGO: "",
//            KEY_COLOR_PRIMARY: "",
//            KEY_COLOR_SECUNDARY: "",
//            KEY_DISABLE_BACK: false,
//            KEY_HOME_MESSAGE_ES: "",
//            KEY_HOME_MESSAGE_EN:"",
//            KEY_HOME_MESSAGE_CA:"",
//            KEY_HOME_TITLE_ES: "",
//            KEY_HOME_TITLE_EN:"",
//            KEY_HOME_TITLE_CA:"",
//            KEY_LANGUAGE: "es-ES",
//            KEY_VIDEO_CALL_SYSTEM: "",
//            KEY_VERSION_UPDATE: true
        ])
        
    }
    
    //save login
    public var username: String {
        get { UserDefaults.standard.string(forKey: KEY_USERNAME) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: KEY_USERNAME) }
    }
    
    public var password: String {
        get { UserDefaults.standard.string(forKey: KEY_PASSWORD) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: KEY_PASSWORD) }
    }
    public var saveCredentiales: Bool {
        get { UserDefaults.standard.bool(forKey: KEY_SAVE_CREDENTIALS) }
        set { UserDefaults.standard.set(newValue, forKey: KEY_SAVE_CREDENTIALS) }
    }
    
}
