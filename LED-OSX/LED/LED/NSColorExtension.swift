//
//  NSColorExtension.swift
//  LED
//
//  Created by Jules Kreutzer on 11-04-16.
//  Copyright © 2016 Jules Kreutzer. All rights reserved.
//

import Cocoa
import Foundation

extension NSColor {
    var coreImageColor : CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)
    }
}