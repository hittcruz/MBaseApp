//
//  UIView+Extension.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 12/05/23.
//

import Foundation
import UIKit

extension UIView {
    func handleTap() {
        transform = CGAffineTransform(scaleX: 1.050, y: 1.050)

        // Realizar la animación de rebote
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
            // Deshacer la sobrecompensación y dejar la vista en su tamaño original
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func shadows(opacity: CGFloat, color: CGColor = CGColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)){
        // sombras
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.5
    }
    
    func borders(radius: CGFloat){
    
        // bordes redondeados
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func round() {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRectMake(bounds.midX - width / 2, bounds.midY - width / 2, width, width)).cgPath
        self.layer.mask = mask
    }
}
