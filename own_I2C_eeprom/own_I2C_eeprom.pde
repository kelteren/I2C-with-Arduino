/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <github.com/kelteren> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Thomas Karlsen
 * ----------------------------------------------------------------------------
 */

#include <Wire.h>

#define deviceAddress (0x12 << 3 | 0x0)

int pointer = 0x0;
int eepromSize = 0x1FFF;


void setup(){
  Wire.begin();          //enable I2C
  Serial.begin(9600);    // for debuggin, reading of data
}


void loop(){

}

byte readByte(arg 1, arg 2){
  Wire.beginTransmission(deviceAddress);
  Wire.send();
  Wire.send();
  Wire.endTransmission();
  
  Wire.requestFrom(deviceAddress);
  byte MSB = Wire.receive();
  byte LSB = Wire.receive();
  
  return something;  
}


void writeByte(){
  Wire.beginTransmission(deviceAddress);
  Wire.send();
  Wire.send();
  Wire.endTransmission();
}
