/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <github.com/kelteren> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Thomas Karlsen
 * ----------------------------------------------------------------------------
 */

// sketch to read entire chip 32 bytes at a time, display on serial monitor with progress indicated.
// July2010- Volkemon tweaked and commented.
//	_ _
//  A0-|oU |-Vcc
//  A1-|   |-WP
//  A2-|   |-SCL
// Vss-|   |-SDA
//	---
//
//   SDA goes to Arduino 4
//   SCL goes to Arduino 5
//   WP  goes to ground for now. Can be put to Vcc if write protection is needed.
//   Vcc goes to arduino Vcc
//   Vss goes to arduino ground
//   A2, A1, A0 go to ground for now.
//
// They can be also put to either ground or Vcc to control up to 8 memory chips (2^3), giving you 2MBit of memory (8*2^15).
// A2 A1 A0 Binary Address Hex Address
// 0  0  0    0b1010000       0×50
// 0  0  1    0b1010001       0×51
// 0  1  0    0b1010010       0×52
// 0  1  1    0b1010011       0×53
// 1  0  0    0b1010100       0×54
// 1  0  1    0b1010101       0×55
// 1  1  0    0b1010110       0×56
// 1  1  1    0b1010111       0×57
  
#include <Wire.h>

char  chipAdress=0x50;        // Binary 10100000 . Three bits after 1010 (currently 000) are used to specify to what A2, A1, A0 are connected to, ground or vcc. See comment above. Last bit specifies the opertation - 0 for write, 1 for read. This is controlled for you by the Wire library. :)
int   block = 0;

void setup()
{
  Wire.begin();           // enable the i2c bus
  Serial.begin(19200);   // Did you set your serial monitor to 19200?
  Wire.beginTransmission(chipAdress);    // chip address on the TWI bus, not chip memory address.
  
                  //Set up the chip Internal Address Pointer to the beginning of memory

  Wire.send(0x00);      
  Wire.send(0x00);    
  
  Wire.endTransmission(); // sends Wire buffer to chip, sets Internal Address Pointer to '0' 
}

void loop()
{
  Serial.print(block);
  Serial.print  ("\t");
  Wire.requestFrom(chipAdress, 32);          // requests 32 Bytes of data in a packet, maximum string size.
  while(Wire.available())                   // 'while loop' start, Checks to see if data is waiting
  {
    Serial.print(" ");                       // space to format packets on serial monitor
    Serial.print(Wire.receive(),HEX);      // print the values received on the serial monitor
  }                                          // end bracket for 'while loop'
  Wire.endTransmission();                    // when 'while loop' is finished (no more data available) 'closes' chip

  Serial.println("");

  if (block >= 255)
  {
    Serial.println("End Of Memory");
    while(true){                              // press reset if you want a new printout
      //nada                                
    }
  }else
  {
    block += 1;    
  }
  delay(30);
}