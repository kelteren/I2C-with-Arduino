#include <Wire.h>

int ledA = 7;
int ledB = 6;
int ledC = 5;
int ledD = 4;

int tid  = 750;

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

    delay(tid);
  }
}


void show(int tall)
{
  digitalWrite(ledA, (tall & B1) && HIGH);
  digitalWrite(ledB, (tall & B10) && HIGH);
  digitalWrite(ledC, (tall & B100) && HIGH);
  digitalWrite(ledD, (tall & B1000) && HIGH);
}

