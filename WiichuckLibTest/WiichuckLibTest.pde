/*
 * WiiChuckLibTest 
 *
 * Bibliotek lastet fra http://todbot.com/blog/2008/02/18/wiichuck-wii-nunchuck-adapter-available/
 * (http://todbot.com/arduino/sketches/WiichuckDemo.zip)
 *
 */

#include <Wire.h>
#include "nunchuck_funcs.h"

int loop_cnt=0;

byte joyx,joyy,accx,accy,accz,zbut,cbut;
int ledPin = 13;


void setup(){
    pinMode(ledPin,OUTPUT);
  
    Serial.begin(19200);
    nunchuck_setpowerpins();
    nunchuck_init(); // Initierings-kommando
    
    Serial.print("WiiChuckDemo klar\n");
}

void loop()
{
    if( loop_cnt > 50 ) { // hent data hvert 100de msek
        loop_cnt = 0;

        nunchuck_get_data();

        joyx  = nunchuck_joyx();  // typisk 28 - 125 - 226 på min kontroller
        joyy  = nunchuck_joyy();  // typisk 40 - 137 - 232 på min kontroller

        accx  = nunchuck_accelx(); // typisk 72 - 131 - 180 på min kontroller
        accy  = nunchuck_accely(); // typisk 75 - 130 - 180  på min kontroller
        accz  = nunchuck_accelz(); // typisk 88 - 195 på min kontroller

        zbut  = nunchuck_zbutton(); 
        cbut  = nunchuck_cbutton();
            
        if(zbut == 1){
          digitalWrite(ledPin,HIGH);
        }else{
          digitalWrite(ledPin,LOW);
        }
            
        Serial.print("joyx: ");   Serial.print((byte)joyx,DEC);
        Serial.print("\tjoyy: ");   Serial.print((byte)joyy,DEC);
        Serial.print("\taccx: "); Serial.print((byte)accx,DEC);
        Serial.print("\taccy: "); Serial.print((byte)accy,DEC);
        Serial.print("\taccz: "); Serial.print((byte)accz,DEC);
        Serial.print("\tzbut: "); Serial.print((byte)zbut,DEC);
        Serial.print("\tcbut: "); Serial.println((byte)cbut,DEC);
    }
    loop_cnt++;
    delay(1);
}
