//
//  DisplayLinkWrapper.swift
//  
//
//  Created by Mykhailo Glagola on 13.07.2023.
//

import UIKit
import Combine

class DisplayLinkWrapper {
    private var displayLink: CADisplayLink?
    var prefferedRefreshRate: Float {
        didSet {
            updateDisplayLinkPrefferedFrameRate()
        }
    }
    
    let refresh = PassthroughSubject<Void, Never>()
    
    init(prefferedRefreshRate: Float = 1) {
        self.prefferedRefreshRate = prefferedRefreshRate
    }
    
    func start() {
        if case .some = displayLink {
            stop()
        }
        
        let displayLink = CADisplayLink(target: self, selector: #selector(displayLinkFire(_:)))
        updateDisplayLinkPrefferedFrameRate()
        displayLink.add(to: .main, forMode: .default)
    }
    
    func stop() {
        displayLink?.remove(from: .main, forMode: .default)
        displayLink = nil
    }
    
    @objc private func displayLinkFire(_ link: CADisplayLink) {
        refresh.send()
    }
    
    private func updateDisplayLinkPrefferedFrameRate() {
        if #available(iOS 15.0, *) {
            displayLink?.preferredFrameRateRange = .init(minimum: 0, maximum: prefferedRefreshRate, __preferred: prefferedRefreshRate)
        } else {
            displayLink?.preferredFramesPerSecond = Int(prefferedRefreshRate)
        }
    }
}
