// Date and time functions using a DS1307 RTC connected via I2C and Wire lib
// Temperature using DS18S20 Temperature sensor connected using onewire protocol
// Display using 4-character 7-segment display from sparkfun

#include <Wire.h>
#include <RTClib.h>
#include <OneWire.h>

OneWire ds(7);  // temp-DQ on pin 7, remember a pull-up resistor of about 4.7 KOhm

RTC_DS1307 RTC;

int gndPin = 16;  // analog 2
int vccPin = 17;  // analog 3

void setup () {
    Serial.begin(9600);
//    Serial.print("initialising");

    pinMode(gndPin,OUTPUT);
    pinMode(vccPin,OUTPUT);
  
    digitalWrite(gndPin,LOW);
    digitalWrite(vccPin,HIGH);

    delay(100);
//    Serial.print(".");

    Wire.begin();
    RTC.begin();

//    Serial.print(".");

//  if (! RTC.isrunning()) {
    // following line sets the RTC to the date & time this sketch was compiled
//    RTC.adjust(DateTime(__DATE__, __TIME__));
//  }
//    Serial.println(".");
//    Serial.print("z");Serial.print(0x33,BYTE);  
//    Serial.print("y");Serial.print(0x02,BYTE);  
}

void loop () {
//----------------------------------------- show the time
//    Serial.println("will now show the time");
    if (! RTC.isrunning()) {
//      Serial.println("RTC is NOT running!");
    }else{
//      Serial.println("RTC is running!");      
    }

    DateTime now = RTC.now();
    
    //show time for 4 seconds
    
    for(int i = 0; i < 1; i++){
      Serial.print("w");Serial.print(B00110000,BYTE);
      
      if(now.hour() < 10){
        Serial.print("0");
        Serial.print(now.hour(), DEC);
      }else{
        Serial.print(now.hour(), DEC);
      }
      
      if(now.minute() < 10){
        Serial.print("0");
        Serial.print(now.minute(), DEC);
      }else{
        Serial.print(now.minute(), DEC);        
      }
      delay(1000);
      Serial.print("w");Serial.print(B00000000,BYTE);

      if(now.hour() < 10){
        Serial.print("0");
        Serial.print(now.hour(), DEC);
      }else{
        Serial.print(now.hour(), DEC);
      }
      
      if(now.minute() < 10){
        Serial.print("0");
        Serial.print(now.minute(), DEC);
      }else{
        Serial.print(now.minute(), DEC);        
      }
      delay(1000);
    }
  
    
//----------------------------------------- show the temperature
//  Serial.println("will now show the temperature");
  int HighByte, LowByte, TReading, SignBit, Tc_100, Whole, Fract;
  byte i;
  byte present = 0;
  byte data[12];
  byte addr[8];

  if ( !ds.search(addr)) {
//      Serial.print("No more addresses.\n");
      ds.reset_search();
      return;
  }

//  Serial.print("R=");
  for( i = 0; i < 8; i++) {
//    Serial.print(addr[i], HEX);
//    Serial.print(" ");
  }

  if ( OneWire::crc8( addr, 7) != addr[7]) {
//      Serial.print("CRC is not valid!\n");
      return;
  }

//  if ( addr[0] == 0x10) {
//      Serial.print("Device is a DS18S20 family device.\n");
//  }
//  else if ( addr[0] == 0x28) {
//      Serial.print("Device is a DS18B20 family device.\n");
//  }
//  else {
//      Serial.print("Device family is not recognized: 0x");
//      Serial.println(addr[0],HEX);
//      return;
//  }

  ds.reset();
  ds.select(addr);
  ds.write(0x44,1);         // start conversion, with parasite power on at the end

  delay(750);     // maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it.

  present = ds.reset();
  ds.select(addr);    
  ds.write(0xBE);         // Read Scratchpad

//  Serial.print("P=");
//  Serial.print(present,HEX);
//  Serial.print(" ");
  for ( i = 0; i < 9; i++) {           // we need 9 bytes
    data[i] = ds.read();
//    Serial.print(data[i], HEX);
//    Serial.print(" ");
  }
//  Serial.print(" CRC=");
//  Serial.print( OneWire::crc8( data, 8), HEX);
//  Serial.println();
  LowByte = data[0];
  HighByte = data[1];
  TReading = (HighByte << 8) + LowByte;
  SignBit = TReading & 0x8000;  // test most sig bit
  if (SignBit) // negative
  {
    TReading = (TReading ^ 0xffff) + 1; // 2's comp
  }
  Tc_100 = (6 * TReading) + TReading / 4;    // multiply by (100 * 0.0625) or 6.25

  Whole = Tc_100 / 100;  // separate off the whole and fractional portions
  Fract = Tc_100 % 100;
//  Fract = Fract / 10;


  Serial.print("w");Serial.print(B00000010,BYTE);
  if (SignBit) // If its negative
  {
     Serial.print("-");
  }
  if (Whole < 10)
  {
     Serial.print("0");
  }
  Serial.print(Whole);
//  Serial.print(".");
  if (Fract < 10)
  {
     Serial.print("0");
  }
  Serial.print(Fract);
//  Serial.print(Fract,BYTE);
//  Serial.print("x");
  delay(4000);    
}
