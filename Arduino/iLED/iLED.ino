/*
Copyright (c) 2011 Stonehippo Code & Consulting

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

// Photoresistor pin (analog)
int photoPin = 0;

// PWM-capable pin for physical LED (digital)
int ledPin = 9;

void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(57600);
}

void loop() {
  int lightLevel = readLightLevel();

  analogWrite(ledPin, lightLevel);
  txLightLevel(lightLevel);
  delay(100);
}

int readLightLevel() {
  // You may need to alter the maxValue, depending on the device generating the values
  // For example, my LDP had max around 900 with used with a voltage divider.
  int maxReading = 1023;
  int lightLevel = analogRead(photoPin);
  lightLevel = map(lightLevel, 0, 1023, 0, 255);
  lightLevel = constrain(lightLevel, 0, 255);
  return lightLevel; 
}

void txLightLevel(int lightLevel) {
 Serial.println(lightLevel);
}
