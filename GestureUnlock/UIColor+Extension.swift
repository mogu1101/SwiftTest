//
//  UIColor+Extension.swift
//  GestureUnlock
//
//  Created by LiuJinjun on 16/7/27.
//  Copyright © 2016年 NetEase Youdao. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(random())/CGFloat(RAND_MAX), green: CGFloat(random())/CGFloat(RAND_MAX), blue: CGFloat(random())/CGFloat(RAND_MAX), alpha: 1.0)
    }
}
