//
//  AlertHandler.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 23/06/23.
//

import Foundation
import UIKit

final class AlertHandler{
    static func showError(error: Error) {
        
        guard let currentVC = UIApplication.topViewController() else { return }
        
        let alertView = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            currentVC.navigationController?.popViewController(animated: true)
        }
        
        alertView.addAction(dismissButton)
        
        currentVC.present(alertView, animated: true)
    }
    
    static func showAlert(title: String, msg: String, firstButtonTitle: String = "OK", dismissButtonTitle: String = "Cancel", action: (() -> Void)? = nil, dismissAction: (() -> Void)? = nil) {
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let firstButton = UIAlertAction(title: firstButtonTitle, style: .default) { _ in
            action?()
        }

        let dismissButton = UIAlertAction(title: dismissButtonTitle, style: .cancel) { _ in
            dismissAction?()
        }

        alertView.addAction(firstButton)
        alertView.addAction(dismissButton)

        guard let currentVC = UIApplication.topViewController() else { return }
        currentVC.present(alertView, animated: true)
    }
}

