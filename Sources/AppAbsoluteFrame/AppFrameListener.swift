//
//  AppFrameListener.swift
//  
//
//  Created by Mykhailo Glagola on 13.07.2023.
//

import UIKit
import Combine

/// `AppFrameListener` listens to window frame changes. However, if the application is in Slide Over mode where the window frame doesn't change, a DisplayLinkHelper is used to refresh the data every second.
public class AppFrameListener {
    /// Applicaction's frame on the screen
    @Published public var applicationFrame: CGRect = .zero
    ///A scene associated with the window.
    public private(set) weak var scene: UIWindowScene?
    ///A window, the frame of which is being observed.
    public private(set) weak var window: UIWindow?
    
    
    private var subscriptions = Set<AnyCancellable>()
    ///Wrapper for a `CADysplayLink`
    private let displayLinkWrapper: DisplayLinkWrapper
    
    /// Initialize the class with the scene associated with the window whose frame should be observed. The class holds a weak reference to both the scene and the window. After initialization, you should call the startListening() method to receive the updates.
     /// Call `stopListening()` when the updates are no longer needed. If the window or scene becomes released, the class automatically calls `stopListening()`.
    /// - Parameters:
    ///   - scene: UIWindowScene associated with the window whose frame should be observed
    ///   - window: UIWindow whose frame should be observed
    ///   - refreshRate: Refresh rate of the window frame. Default value is 1
    
    public init(scene: UIWindowScene, window: UIWindow, refreshRate: Float = 1) {
        self.window = window
        self.scene = scene
        displayLinkWrapper = DisplayLinkWrapper(prefferedRefreshRate: refreshRate)
    }
    ///Subscribes to publisher and starts to send frame change events
    public func startListening() {
        subscribeToPublishers()
    }
    ///Cancels subscriptions and stops sending frame updates.
    public func stopListening() {
        unsubscribeFromPublishers()
    }
    
    private func subscribeToPublishers() {
        window?.publisher(for: \.frame)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateProperties()
            }
            .store(in: &subscriptions)
        
        displayLinkWrapper.refresh
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.updateProperties()
            }
            .store(in: &subscriptions)
        displayLinkWrapper.start()
    }
    
    private func unsubscribeFromPublishers() {
        for subscription in subscriptions {
            subscription.cancel()
        }
        subscriptions.removeAll()
        displayLinkWrapper.stop()
    }
    
    @objc private func updateProperties() {
        guard let window = window, let scene = scene else {
            stopListening()
            return
        }
        let newFrame = AppAbsoluteFrame(window: window, scene: scene).frame
        if applicationFrame != newFrame {
            applicationFrame = newFrame
        }
    }
}


