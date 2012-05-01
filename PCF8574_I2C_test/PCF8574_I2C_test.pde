/*
  Test program for two PCF8574 I2C I/O expanders
  - Blinks all ports low then high.

*/

#include <Wire.h>

#define expander1 B0111000  // Address with A0,A1,A2 address pins grounded.
#define expander2 B0111101  // Address with A1 address pins grounded, A1 to HIGH

int delayTime = 2000;

void setup() {
  Wire.begin();
  Serial.begin(9600);
}

void loop() {
  Serial.println("Writing B00000000 to expander 1.");
  expander1Write(B00000000);
  Serial.print("Read: ");
  Serial.println(expander1Read(), BIN);
  delay(delayTime);
  Serial.println("Writing B11111111 to expander 1.");
  expander1Write(B11111111);
  Serial.print("Read: ");
  Serial.println(expander1Read(), BIN);
  delay(delayTime);
  
  Serial.println("Writing B00000000 to expander 2.");
  expander2Write(B00000000);
  Serial.print("Read: ");
  Serial.println(expander2Read(), BIN);
  delay(delayTime);
  Serial.println("Writing B11111111 to expander 2.");
  expander2Write(B11111111);
  Serial.print("Read: ");
  Serial.println(expander2Read(), BIN);
  delay(delayTime);
  
}


void expander1Write(byte _data ) {
  Wire.beginTransmission(expander1);
  Wire.send(_data);
  Wire.endTransmission();
}

byte expander1Read() {
  byte _data;
  Wire.requestFrom(expander1, 1);
  if(Wire.available()) {
    _data = Wire.receive();
  }
  return _data;
}
 
void expander2Write(byte _data ) {
  Wire.beginTransmission(expander2);
  Wire.send(_data);
  Wire.endTransmission();
}

byte expander2Read() {
  byte _data;
  Wire.requestFrom(expander2, 1);
  if(Wire.available()) {
    _data = Wire.receive();
  }
  return _data;
}
 


