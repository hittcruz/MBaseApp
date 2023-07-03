//
//  ConstantPrivate.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 23/06/23.
//

import Foundation
import UIKit

public enum ConstantsPrivate {
    enum ServiceCode{
        
    }
    enum Services {
        struct BaseURL {
            static let pre = "http://192.168.1.3:8000/api"
            static let pro = "http://192.168.1.3:8000/api"
        }
        static let sessionTimeoutCode = "WRC_0003"
    }
    
    enum orderOptions: String, CaseIterable {
        case create = "CR"
        case cancel = "CN"
        case pending = "PR"
        case finished = "FN"
        
        func getTitle()-> String{
            switch self {
            case .create:
                return "Creados "
            case .cancel:
                return "Cancelados "
            case .pending:
                return "Pendientes "
            case .finished:
                return "Finalizados "
            }
        }
        
        func getColor() -> UIColor {
            switch self {
            case .create:
                return UIColor.black
            case .cancel:
                return UIColor.red
            case .pending:
                return UIColor.blue
            case .finished:
                return UIColor.systemGreen
            }
        }
    }
}

