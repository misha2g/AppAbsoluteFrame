//
//  CGAffineTransform.swift
//  
//
//  Created by Mykhailo Glagola on 13.07.2023.
//

import UIKit

extension CGAffineTransform {
    init(_ interfaceOrientation: UIInterfaceOrientation, fixedScreenBounds: CGRect) {
        var rotation: CGFloat = 0
        var translation = CGPoint.zero
        switch interfaceOrientation {
        case .landscapeLeft:
            rotation = .pi/2
            translation.y = -fixedScreenBounds.height
        case .landscapeRight:
            rotation = -.pi/2
            translation.x = -fixedScreenBounds.width
        case .portraitUpsideDown:
            rotation = .pi
            translation.x = -fixedScreenBounds.width
            translation.y = -fixedScreenBounds.height
        default:
            break
        }
        
        let transform = CGAffineTransform(rotationAngle: rotation).translatedBy(x: translation.x, y: translation.y)
        
        self = transform
    }
}
