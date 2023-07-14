//
//  CGRect.swift
//  
//
//  Created by Mykhailo Glagola on 13.07.2023.
//

import UIKit

extension CGRect {
    /// Rounded to nearest or even all properties
    var rounded: CGRect {
        CGRect(x: origin.x.rounded(.toNearestOrEven),
               y: origin.y.rounded(.toNearestOrEven),
               width: width.rounded(.toNearestOrEven),
               height: height.rounded(.toNearestOrEven))
    }
}
