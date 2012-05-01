#include <Wire.h>

int   senAdr = 0x91 >> 1;
byte  hB;
byte  lB;
int   temp;
int   tempA;
int   tempB;

void setup(){
  Serial.begin(9600);
  Wire.begin();
  delay(100);
  Serial.print("z");Serial.print(B00011000,BYTE);
  delay(100);
}

void loop(){
  
  Wire.requestFrom(senAdr,2);
  
  if(Wire.available() >= 2){   
    hB = Wire.receive();  //full degrees
    lB = Wire.receive();  //fractional degrees
    
    temp = ((hB) << 4);
    temp |= ((lB) >> 4);

    Serial.print("w");Serial.print(B01000010,BYTE);
    Serial.print(int(temp*0.625),DEC);Serial.print("C");
    delay(20);
  }
  delay(500);
}

