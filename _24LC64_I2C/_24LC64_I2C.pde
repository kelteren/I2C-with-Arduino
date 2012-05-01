
byte chipAddress  = 0x50;
int block = 0;

#include <Wire.h>

void setup(){
  wire.begin();        //enable I2C
  Serial.begin(9600);  //for debugging/reading of data
  
  Wire.beginTransmission(chipAddress);    // chip address on the TWI bus, not chip memory address. Set up the chip Internal Address Pointer to the beginning of memory
  Wire.send(0x00);      
  Wire.send(0x00);    
  Wire.endTransmission(); // sends Wire buffer to chip, sets Internal Address Pointer to '0'
}

void main(){
  Serial.println(" ");
  Serial.println(block);
  Wire.requestFrom(chipAddress,32);
  while(Wire.available() ){
    Serial.print("  ");
    Serial.print(Wire.receive(),HEX);
  }
  Wire.endTransmission();
  delay(10000);
}


















