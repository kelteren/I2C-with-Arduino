#include <Wire.h>

int slaveAddress = (B0111 << 3) | 0x0;
int delayTime = 2000;
//#define slaveAddress B0111000

void setup(){
  Serial.begin(9600);
  Wire.begin();
  Serial.print("adresse til expander: ");
  Serial.println(slaveAddress,BIN);
}


void loop(){
  Serial.println("Skriver 0x00 til expander");
  skrivData(0x00);
  Serial.print("Avlest: ");
  Serial.println(lesData(), BIN);
  delay(delayTime);
  Serial.println("Skriver 0xFF til expander");
  skrivData(0xFF);
  Serial.print("avlest: ");
  Serial.println(lesData(), BIN);
  delay(delayTime);
}

void skrivData(byte _data){
  Wire.beginTransmission(slaveAddress);
  Wire.send(_data);
  Wire.endTransmission();
}

byte lesData(){
  byte _data;
  Wire.requestFrom(slaveAddress,1);
  if(Wire.available()){
    _data = Wire.receive();
  }  
  return _data;  
}
