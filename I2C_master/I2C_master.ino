
/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <github.com/kelteren> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Thomas Karlsen
 * ----------------------------------------------------------------------------
 */


#include <Wire.h>

int ledA = 7;
int ledB = 6;
int ledC = 5;
int ledD = 4;

int jiffy  = 750;

void setup()
{
  Wire.begin();

  pinMode(ledA,OUTPUT);
  pinMode(ledB,OUTPUT);
  pinMode(ledC,OUTPUT);
  pinMode(ledD,OUTPUT);
}

void loop()
{

  for(byte teller = 0 ; teller<16 ; teller++){

    show(teller);

    Wire.beginTransmission(2);
    Wire.write(teller);
    Wire.endTransmission();

    delay(jiffy);
  }
}


void show(int tall)
{
  digitalWrite(ledA, (tall & B1) && HIGH);
  digitalWrite(ledB, (tall & B10) && HIGH);
  digitalWrite(ledC, (tall & B100) && HIGH);
  digitalWrite(ledD, (tall & B1000) && HIGH);
}

