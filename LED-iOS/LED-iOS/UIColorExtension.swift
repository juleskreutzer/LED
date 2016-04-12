//
//  UIColorExtension.swift
//  LED-iOS
//
//  Created by Jules Kreutzer on 12-04-16.
//  Copyright © 2016 Jules Kreutzer. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    var coreImageColor : CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)
    }
}
