# AppAbsoluteFrame

## Description
The AppAbsoluteFrame module is designed to calculate the real on-screen application frame, which can be particularly useful for iPad users in Split View and Slide Over modes. It provides a simple and reliable solution for obtaining the actual frame dimensions of your application's window when it is displayed alongside other apps on an iPad.

## Features
- Accurate Frame: The AppAbsoluteFrame module accurately calculates the dimensions of your application's frame, accounting for any adjustments made in Split View or Slide Over mode on iPad.
- AppFrameListener: The module includes an AppFrameListener, which allows you to subscribe and receive updates each time the application frame changes. This enables you to dynamically respond to changes in the frame dimensions.
- Seamless Integration: The AppAbsoluteFrame module seamlessly integrates with your existing codebase, providing an easy-to-use API for retrieving the current frame of your application.

## Usage
### Get application current frame
- Initialize the `AppAbsoluteFrame` with a scene associated with the window you want to retrieve the frame from, as well as the window itself.
- Access the following properties:
	- `fixedScreenBounds: CGRect` representing the screen bounds in the fixed coordinate space (iPad in portrait mode).
 	- `fixedAppFrame: CGRect`  representing the application frame in the fixed coordinate space (iPad in portrait mode).
 	- `transform: CGAffineTransform` representing the application frame in the fixed coordinate space (iPad in portrait mode).
 	- `screenBounds: CGRect` representing the screen bounds in the current coordinate space. 	- `frame: CGRect` representing the current application frame on the screen.

### Usage of `AppFrameListener`
- Initialize the `AppFrameListener` with a scene associated with the window you want to retrieve the frame from, as well as the window itself and desired refresh rate.
- Subscribe to the applicationFrame publisher.
- Call `startListening()` to begin receiving updates.
- Call `stopListening()` when you no longer need to receive updates.
- The `AppFrameListener` holds `weak` references to the scene and window. If either of them is released, the class will automatically call `stopListening()`.

##License
The AppAbsoluteFrame module is released under the [MIT License](https://opensource.org/license/mit/).
