//
//  UIViewControllerExtension.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation
import UIKit

public extension UIViewController {
    func showLoader() {
        let activity = UIActivityIndicatorView()
        guard let window = UIApplication.shared.keyWindow else {return}
        let backgroundAlphaView = UIView(frame: window.bounds)
        backgroundAlphaView.tag = 789
        backgroundAlphaView.backgroundColor = .clear
        window.addSubview(backgroundAlphaView)
        backgroundAlphaView.translatesAutoresizingMaskIntoConstraints = false
        backgroundAlphaView.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
        backgroundAlphaView.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
        backgroundAlphaView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        backgroundAlphaView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        backgroundAlphaView.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: backgroundAlphaView.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: backgroundAlphaView.centerYAnchor).isActive = true
        activity.style = .whiteLarge
//        let setColorByEntity = RemoteLib.shared.settingsManager.primaryColorByEntity
//        activity.color = setColorByEntity.isEmpty ? ConstantsPrivate.Colors.baseColour() :  UIColor(RemoteLib.shared.settingsManager.primaryColorByEntity)
        activity.color = .systemGreen
        activity.hidesWhenStopped = true
        activity.isHidden = false
        activity.startAnimating()
    }

    func hideLoader() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else {return}
            if let activity = window.viewWithTag(789) {
                activity.removeFromSuperview()
            }
        }
    }
}
