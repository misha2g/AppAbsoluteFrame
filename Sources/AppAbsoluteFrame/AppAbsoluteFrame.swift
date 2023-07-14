import UIKit

/// The AppAbsoluteFrame struct accurately calculates the dimensions of your application's frame, accounting for any adjustments made in Split View or Slide Over mode on iPad.
public struct AppAbsoluteFrame {
    public let window: UIWindow
    public let scene: UIWindowScene
    /// The fixed screen bounds represent the iPad in portrait mode.
    public var fixedScreenBounds: CGRect {
        scene.screen.fixedCoordinateSpace
            .convert(scene.screen.bounds, from: scene.coordinateSpace)
    }
    
    /// Represents application frame in fixed coordinate space (see `fixedScreenBounds`property)
    public var fixedAppFrame: CGRect {
        window.convert(window.bounds, to: scene.screen.fixedCoordinateSpace)
    }
    
    /// A transform needs to be applied to a rectangle or point in order to convert them from the fixed coordinate space to the current coordinate space when the device is rotated.
    public var transform: CGAffineTransform {
        CGAffineTransform(scene.interfaceOrientation, fixedScreenBounds: fixedScreenBounds)
    }
    
    /// Current screen bounds
    public var screenBounds: CGRect {
        fixedScreenBounds.applying(transform).rounded
    }
    
    /// Curent application frame on screen
    public var frame: CGRect {
        fixedAppFrame.applying(transform).rounded
    }
    
    public init(window: UIWindow, scene: UIWindowScene) {
        self.window = window
        self.scene = scene
    }
}



