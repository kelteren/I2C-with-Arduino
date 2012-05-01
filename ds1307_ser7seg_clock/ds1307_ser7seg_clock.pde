// Date and time functions using a DS1307 RTC connected via I2C and Wire lib

#include <Wire.h>
#include "RTClib.h"

RTC_DS1307 RTC;

int gndPin = 2;
int vccPin = 3;


void setup () {
  
    analogWrite(gndPin,LOW);
    analogWrite(vccPin,HIGH);
  
    Serial.begin(9600);
    Wire.begin();
    RTC.begin();

  if (! RTC.isrunning()) {
    // following line sets the RTC to the date & time this sketch was compiled
    RTC.adjust(DateTime(__DATE__, __TIME__));
  }
}

void loop () {
    DateTime now = RTC.now();
    
    Serial.print(now.hour(), DEC);
    Serial.print(now.minute(), DEC);
//    Serial.print(0x77);
//    Serial.print(0x30);
    
    delay(250);
}
