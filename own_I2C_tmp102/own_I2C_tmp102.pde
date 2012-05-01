/***********************************************
*
*  TMP102
*
*
*  Arduino analog input 5 - I2C SCL
*  Arduino analog input 4 - I2C SDA
*
***********************************************/

 

#include <Wire.h>


int ptrTemp  =  0x0;  //  0b00000000;	   // TMP102 temperature register pointers
int ptrConf  =  0x1;  //  0b00000001;     // TMP102 configuration register pointers
int ptrTLow  =  0x2;  //  0b00000010;	   // TMP102 Tlow register pointers
int ptrTHigh =  0x3;  //  0b00000011;	   // TMP102 Thighregister pointers

// I2C address is 10010 A A
#define deviceAddress (0x12 << 2 | 0x0)

byte res;
float val;


void setup(){
  Serial.begin(9600);
  Wire.begin();
  
  Serial.print("Configuration register, HEX: ");
  Serial.println(getConfReg(),HEX);

  Serial.print("Configuration register, Bin: ");
  Serial.println(getConfReg(),BIN);
  
  Serial.print("Temp high: ");
  Serial.println(getThigh());
  
  Serial.print("Temp Low: ");
  Serial.println(getTlow());
}

void loop(){
  Serial.print("Celsius: ");
  Serial.println(getTemp());
  delay(2500);
}


float getTemp(){
  Wire.beginTransmission(deviceAddress);
  Wire.send(ptrTemp);
  Wire.endTransmission();	     // be done once in setup() )

  Wire.requestFrom(deviceAddress,2); 
  byte MSB = Wire.receive();
  byte LSB = Wire.receive();

  int TemperatureSum = ((MSB << 8) | LSB) >> 4; // if positive temperature
  float celsius = TemperatureSum*0.0625;
  float fahrenheit = (TemperatureSum*0.1125) + 32;  

  return celsius;
}

int getConfReg(){
  Wire.beginTransmission(deviceAddress);  // select temperature register
  Wire.send(ptrConf);
  Wire.endTransmission();	     // be done once in setup() )

  Wire.requestFrom(deviceAddress, 2);     // request temperature
  byte MSB = Wire.receive();
  byte LSB = Wire.receive();

//  return (((MSB << 8) | LSB) >> 4);
  return ((MSB << 8) | LSB);
}

float getTlow(){
  Wire.beginTransmission(deviceAddress);  // select temperature register
  Wire.send(ptrTLow);
//  Wire.send(24);  // (if only temperature is needed this can
  Wire.endTransmission();	     // be done once in setup() )

  Wire.requestFrom(deviceAddress, 2);     // request temperature
  byte MSB = Wire.receive();
  byte LSB = Wire.receive();    
  
//  return ((MSB << 8) | LSB);  
  int TemperatureSum = ((MSB << 8) | LSB) >> 4; // if positive temperature
  float celsius = TemperatureSum*0.0625;

  return celsius;
}

float getThigh(){
  Wire.beginTransmission(deviceAddress);  // select temperature register
  Wire.send(ptrTHigh);  
//  Wire.send(28);    // (if only temperature is needed this can
  Wire.endTransmission();	     // be done once in setup() )

  Wire.requestFrom(deviceAddress, 2);     // request temperature
  byte MSB = Wire.receive();
  byte LSB = Wire.receive();    

//  return ((MSB << 8) | LSB);
  int TemperatureSum = ((MSB << 8) | LSB) >> 4; // if positive temperature
  float celsius = TemperatureSum*0.0625;

  return celsius;
}

//setConfReg(){}

//setTlow(){}

//setThigh(){}


