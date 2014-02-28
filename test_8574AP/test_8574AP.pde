#include <Wire.h>

int slaveAddress = (B0111 << 3) | 0x0;
int delayTime = 2000;
//#define slaveAddress B0111000

void setup(){
  Serial.begin(9600);
  Wire.begin();
  Serial.print("adress to expander: ");
  Serial.println(slaveAddress,BIN);
}


void loop(){
  Serial.println("Writing 0x00 to expander");
  skrivData(0x00);
  Serial.print("Read: ");
  Serial.println(readData(), BIN);
  delay(delayTime);
  Serial.println("Writing 0xFF to expander");
  skrivData(0xFF);
  Serial.print("Read: ");
  Serial.println(readData(), BIN);
  delay(delayTime);
}

void writeData(byte _data){
  Wire.beginTransmission(slaveAddress);
  Wire.send(_data);
  Wire.endTransmission();
}

byte readData(){
  byte _data;
  Wire.requestFrom(slaveAddress,1);
  if(Wire.available()){
    _data = Wire.receive();
  }  
  return _data;  
}
