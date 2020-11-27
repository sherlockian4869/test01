//
//  UIColor-Extension.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/22.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
