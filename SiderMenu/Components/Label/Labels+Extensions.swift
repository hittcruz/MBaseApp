//
//  Labels+Extensions.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 12/06/23.
//

import UIKit

extension UILabel {
    func flicker(){
        self.textColor = .systemFill
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.textColor = .white
        }
    }
}
