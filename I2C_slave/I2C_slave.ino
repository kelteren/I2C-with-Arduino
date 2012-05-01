/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <github.com/kelteren> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Thomas Karlsen
 * ----------------------------------------------------------------------------
 */

#include <Wire.h>

int ledPin    = 13;
int powerPin  = 3;
int gndPin    = 2;

void setup(){
  pinMode(ledPin, OUTPUT);
  pinMode(powerPin, OUTPUT);
  pinMode(gndPin, OUTPUT);
 
  digitalWrite(powerPin,HIGH);
  digitalWrite(gndPin,LOW);
 
  Serial.begin(9600);
 
  Wire.begin(2);
  Wire.onReceive(mottak);
}


void loop(){
  //nada
}


void mottak(int numBytes){
  byte tall = Wire.read();
  digitalWrite(ledPin, (tall & B1) && HIGH);
//  delay(150);
//  digitalWrite(ledPin,LOW);

  if( tall & 1 ){
    Serial.print(0x0);
    Serial.print(0x0);
    Serial.print(0x0);
    Serial.print(0x1);
  }else{
    Serial.print(0x0);
    Serial.print(0x0);
    Serial.print(0x0);
    Serial.print(0x0);
  }
}
