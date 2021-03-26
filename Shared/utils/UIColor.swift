//
//  UIColor.swift
//  SquatchNotes (iOS)
//
//  Created by Hutson on 3/26/21.
//

import UIKit

public extension UIColor {
    
    static let backgroundDark = UIColor(hex: 0x323339)
    static let backgroundLight = UIColor(hex: 0xE7E4E5)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
    static var squatchBackground: UIColor {
        return UIColor { (traitCollection) -> UIColor in
            switch  traitCollection.userInterfaceStyle {
            case .unspecified:
                return backgroundDark
            case .light:
                return backgroundLight
            case .dark:
                return backgroundDark
            @unknown default:
                fatalError("unknown default")
            }
        }
    }
    
    static var squatchText: UIColor {
        return UIColor { (traitCollection) -> UIColor in
            switch  traitCollection.userInterfaceStyle {
            case .unspecified:
                return backgroundLight
            case .light:
                return backgroundDark
            case .dark:
                return backgroundLight
            @unknown default:
                fatalError("unknown default")
            }
        }
    }
}


