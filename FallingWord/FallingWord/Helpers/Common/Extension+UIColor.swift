//
//  Extension+UIColor.swift
//  FallingWord
//
//  Created by Venkata Subbaiah Sama on 15/09/19.
//  Copyright © 2019 Venkata. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    enum AppColors: Int {
        case red = 0xd0021b
        case green = 0x7ed321
        case green1 = 0x4a992e
        case green2 = 0xa2ff73
        case green3 = 0x1ce3c2
        case green4 = 0x53ac7c
        case blue = 0x527897
        case blue1 = 0x67aeee
        case blue2 = 0x4a90e2
        case blue3 = 0x2a80b9
        case blue4 = 0xc2ffec
        case blue5 = 0x3c99c3
        case grey = 0x333333
        case orange = 0xe86c16
        case orange1 = 0xfe7d18
        case yellow = 0xfeffdb
        case yellow1 = 0xf2c248
        case yellow2 = 0xe6ba19
        case purple = 0x7639bd
        case purple1 = 0xAC5383
        case black = 0x000000
    }
    
    convenience init(appColor: AppColors) {
        self.init(hex: appColor.rawValue)
    }
    
    convenience init(withShade shade: CGFloat, alpha: CGFloat = 1) {
        let red: CGFloat = shade / 255
        let green: CGFloat = shade / 255
        let blue: CGFloat = shade / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
