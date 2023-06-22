//
//  CustomView.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 12/05/23.
//

import Foundation
import UIKit

@IBDesignable
public class GeneralCustomView: UIView {
    
    var cornerMask = CACornerMask()
    
    @IBInspectable
    var cornerTopLeft: CGFloat = 0.0 {
        didSet {
            
            cornerMask.insert(.layerMinXMinYCorner)
            self.layer.cornerRadius = cornerTopLeft
            self.layer.maskedCorners = cornerMask
        }
    }
    
    @IBInspectable
    var cornerTopRight: CGFloat = 0.0 {
        didSet {
            
            cornerMask.insert(.layerMaxXMinYCorner)
            self.layer.cornerRadius = cornerTopRight
            self.layer.maskedCorners = cornerMask
        }
    }
    
    @IBInspectable
    var cornerBottomLeft: CGFloat = 0.0 {
        didSet {
           
            cornerMask.insert(.layerMinXMaxYCorner)
            self.layer.cornerRadius = cornerBottomLeft
            self.layer.maskedCorners = cornerMask
        }
    }
    
    @IBInspectable
    var cornerBottomRight: CGFloat = 0.0 {
        didSet {
            
            cornerMask.insert(.layerMaxXMaxYCorner)
            self.layer.cornerRadius = cornerBottomRight
            self.layer.maskedCorners = cornerMask
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var cornnerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornnerRadius
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor = UIColor.black {
        didSet {
            layer.masksToBounds = false
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 4.0
            layer.shadowColor = shadowColor.cgColor
        }
    }
}
