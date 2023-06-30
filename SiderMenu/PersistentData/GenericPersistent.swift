//
//  GenericPersistent.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 28/06/23.
//

import Foundation

struct Persistent<T> {
    private let defaults = UserDefaults.standard
   
    private let key: String
    private let defaultValue: T?

    init(_ key: String, _ defaultValue: T? = nil) {
        self.key = key

        if let value = defaultValue {
            self.defaultValue = value
        } else {
            switch T.self {
            case is String.Type:
                self.defaultValue = String("") as? T
            case is Int.Type:
                self.defaultValue = Int(0) as? T
            case is Bool.Type:
                self.defaultValue = Bool(false) as? T
            case is Date.Type:
                self.defaultValue = Date() as? T
            case is NSKeyedArchiver.Type:
                self.defaultValue = NSKeyedArchiver(requiringSecureCoding: true) as? T
            default:
                fatalError("Not value found for \(key) of type: \(T.self)")
            }
        }
    }

    var value: T {
        get {
            guard let value = defaults.value(forKey: key) as? T else {
                return defaultValue!
            }
            return value
        }
        set {
            defaults.set(newValue, forKey: key)
        }
    }
}
