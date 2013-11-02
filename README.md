A photo resistor-driven virtual LED for iPhone and Arduino
==========================================================

iLED is a simple iPhone application that displays the state of an Arduino-controlled photo resistor using an on-screen, virtual LED.

iPhone app
----------

The app was built with Xcode 4.2 and targets iOS 5. It could be adapted to earlier versions of iOS. Fork the project if you want to take a crack at that.

You'll need to be a member of the [Apple iOS Developer program](http://developer.apple.com/programs/ios/) to actually install the app on your device.

The hardware
------------

The hardware side of things consists of a few components:

* An Arduino micro-controller board (I used a [Duemilanove](http://arduino.cc/en/Main/ArduinoBoardDuemilanove), but the newer Uno will work great, as will most of the older boards)
* An iOS device running iOS 5 (iPhone|iPad|iPod Touch)
* A Redpark Serial Cable for iOS
* Some form of RS-232 Shifter; I used one from [SparkFun](http://www.sparkfun.com/products/449)
* The parts for the photo resistor circuit (see below)

### Wiring up the circuit ###

I used the [photo resistor circuit design](http://oomlout.com/a/products/ardx/circ-09/) from the oomlout Arduino Experimentation Kit to drive the app. During development, I built out my circuit on an Adafruit Arduino protoshield with a micro-breadboard, but you can build the circuit in any number of ways.

Note that the app should work with just about any photo resistor circuit you care to build. In fact, anything that generates values from 0-255 on the TX portion of the serial circuit would work to drive the virtual LED. 

### iOS-to-Arduino interface ###

This app was designed around the serial-to-iOS interface provided by the Redpark C2-DB9 Serial to 30-pin cable. This cable has a standard male DB-9 serial connector one end and an Apple Dock Connector on the other. The cable uses the iOS External Accessory API to interface with RS-232 serial devices.

There is more information the cable, including the Redpark SDK at the [Redpark Serial Cable for iOS](http://redpark.com/c2db9.html) page.

You can buy the Redpark Serial Cables from the [Maker Shed](http://redpark.com/c2db9.html).

