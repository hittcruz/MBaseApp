//
//  Checkbox.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 11/05/23.
//

import Foundation
import UIKit

public class CheckBox: UIButton {
    
    // Images
    let checkedImage = UIImage(systemName: "square.fill")! as UIImage
    let uncheckedImage = UIImage(systemName: "square")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
//                RemoteLib.shared.setCheckCredential(check: true)
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
//                RemoteLib.shared.setCheckCredential(check: false)
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override public func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
