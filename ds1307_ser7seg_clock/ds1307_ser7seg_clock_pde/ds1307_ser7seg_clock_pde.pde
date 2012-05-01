// Date and time functions using a DS1307 RTC connected via I2C and Wire lib

#include <Wire.h>
#include "RTClib.h"

RTC_DS1307 RTC;

int gndPin = 16;
int vccPin = 17;

void setup () {

    pinMode(gndPin,OUTPUT);
    pinMode(vccPin,OUTPUT);

    digitalWrite(gndPin,LOW);
    digitalWrite(vccPin,HIGH);

    Serial.begin(9600);
    Wire.begin();
    RTC.begin();

    Serial.print("z");Serial.print(0x11,BYTE); //setter lysstyrke
}

void loop () {
    DateTime nuh = RTC.now();
    
    Serial.print("w");Serial.print(B00110000,BYTE);  //slår på kolon
    Serial.print(nuh.hour(),DEC);Serial.print(nuh.minute(),DEC);
    delay(500);
    Serial.print("w");Serial.print(B00000000,BYTE);  //slår av kolon
    Serial.print(nuh.hour(),DEC);Serial.print(nuh.minute(),DEC);
    delay(500);
}
