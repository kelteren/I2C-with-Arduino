/*
  SparkFun Electronics 2010
  Playing with IR remote control
  
  - additions by Thomas Karlsen 2011
  
  IR Receiver TSOP382: Supply voltage of 2.5V to 5.5V
  With the curved front facing you, pin 1 is on the left.
  Attach
    Pin 1: To pin 2 on Arduino
    Pin 2: GND
    Pin 3: 5V
  
  This is based on pmalmsten's code found on the Arduino forum from 2007:
  http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1176098434/0

  This code works with super cheapo remotes. If you want to look at the individual timing
  of the bits, use this code:
  http://www.arduino.cc/playground/Code/InfraredReceivers
  
  This code clips a lot of the incoming IR blips, but what is left is identifiable as key codes.

*/

int irPin = 2; //Sensor pin 1 wired to Arduino's pin 2
int statLED = 13; //Toggle the status LED every time Power is pressed
int start_bit = 2200; //Start bit threshold (Microseconds)
int bin_1 = 1000; //Binary 1 threshold (Microseconds)
int bin_0 = 400; //Binary 0 threshold (Microseconds)

int channel = 0;
int chan_min = 0;

int volume = 0;
int vol_min = 0;
int vol_max = 11;
int mutedVol;

boolean poweredOn = false;
boolean muted     = false;

void setup() {
  pinMode(statLED, OUTPUT);
  digitalWrite(statLED, LOW);

  pinMode(irPin, INPUT);

  Serial.begin(4800);
  Serial.println("Waiting: ");
}

void loop() {
  int key = getIRKey();		    //Fetch the key
  
  if(key != 0){                     //Ignore keys that are zero
    
    switch(key){
      case 144:
        if(!poweredOn){break;}
        Serial.print("Key received: CH Up, channel: ");
        Serial.println(++channel);
        break;
        
      case 145:
        if(!poweredOn){break;}
        Serial.print("Key received: CH Down, channel: "); 
        if(channel > chan_min){
          channel--;
        }
        Serial.println(channel);
        break;
        
      case 146:
        if(!poweredOn){break;}
        Serial.print("Key received: VOL Right, volume: ");
        if(volume < vol_max){
          volume++;
        }
        Serial.println(volume);
      break;
      
      case 147:
        if(!poweredOn){break;}
        Serial.print("Key received: VOL Left, volume: ");
        if(volume > vol_min){
          volume--;            
        }
        Serial.println(volume);
        break;
        
      case 148:
        if(!poweredOn){break;}
        Serial.print("Key received: Mute, "); 
         muted = !muted;
         if (muted){
           mutedVol = volume;
           volume = 0;
         }else{
           volume = mutedVol;
         }
        Serial.print("volume: ");Serial.println(volume);
        break;
        
      case 165: if(!poweredOn){break;} Serial.print("AV/TV"); break;

      case 149:
        Serial.println("Key received: Power");
        poweredOn = !poweredOn;
        digitalWrite(statLED, poweredOn);
        if(poweredOn){
          volume = constrain(volume,0,3);
        }
        break;

      default:
        Serial.print(key);
    } // end switch(key)    
  } // end if key != 0 
} // end loop




int getIRKey() {
  int data[12];
  int i;

  while(pulseIn(irPin, LOW) < start_bit); //Wait for a start bit
  
  for(i = 0 ; i < 11 ; i++)
    data[i] = pulseIn(irPin, LOW); //Start measuring bits, I only want low pulses
  
  for(i = 0 ; i < 11 ; i++) //Parse them
  {	    
    if(data[i] > bin_1) //is it a 1?
      data[i] = 1;
    else if(data[i] > bin_0) //is it a 0?
      data[i] = 0;
    else
      return -1; //Flag the data as invalid; I don't know what it is! Return -1 on invalid data
  }

  int result = 0;
  for(i = 0 ; i < 11 ; i++) //Convert data bits to integer
    if(data[i] == 1) result |= (1<<i);

  return result; //Return key number
} 


