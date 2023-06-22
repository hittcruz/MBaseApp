//
//  Double+Extension.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 22/06/23.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
