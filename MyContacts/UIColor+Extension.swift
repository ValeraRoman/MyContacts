//
//  UIColor+Extension.swift
//  MyContacts
//
//  Created by Macbook Air 13 on 12.02.2021.
//

import Foundation
import UIKit

extension UIColor {
    
 
    
    static var appLightBlue: UIColor {
        return UIColor(hex: 0x5CC7D1)
    }

        
}

extension UIColor {
    
    // MARK: - Public Methods
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
    }
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: alpha)
    }
    
}

// MARK: - UIColor+Hex

extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1) {
        var hex: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        scanner.scanHexInt32(&hex)
        self.init(hex: hex)
    }
    
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255,
                  green: CGFloat((hex >> 8) & 0xFF) / 255,
                  blue: CGFloat(hex & 0xFF) / 255,
                  alpha: alpha)
    }
    
    convenience init(hexWithAlpha: UInt64) {
        self.init(red: CGFloat((hexWithAlpha >> 24) & 0xFF) / 255,
                  green: CGFloat((hexWithAlpha >> 16) & 0xFF) / 255,
                  blue: CGFloat((hexWithAlpha >> 8) & 0xFF) / 255,
                  alpha: CGFloat(hexWithAlpha & 0xFF) / 255)
    }
    
}

