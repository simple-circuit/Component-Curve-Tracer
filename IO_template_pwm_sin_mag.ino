//simple-circuit 12-13-2019 

//A Component Curve Tracer 
//Uses a general purpose serial port driven I/O control program for UNO boards
//baud = 115200 with one stop bit, 8-data bits and no parity
//Works with uno_pwm_ct.exe application

//Serial Commads:

 // @adcNNNN Read ADC pin
 //   Analog pins are NNNN = 0 for A0 to NNNN = 5 for A5.
 //   Returns ad?MMMM\n where ? = A,B,C,D,E,F for channels A0 to A5 
 //   and NNNN = 0000 to 1023,  V = 5*NNNN/1024
 
 // @meaNNNN Generates a minus to plus ramp voltage then returns to zero
 //   Reads Voltage and Current for 256 samples.
 //   Returns meaNNNNMMMM\n where NNNN and MMMM are V then I
 //   V = (NNNN-512)*0.02461 Volts, I = -(NNNN-512)*0.00977 mA 

 
 // @posNNNN Sets the ramp max positive voltage NNNN 0 to 127
  
 // @negNNNN Sets the ramp min negative voltage NNNN 0 to 127

 
 // @cctNNNN Generates a continous sine voltage
 //   Reads Voltage and Current for 256 samples.
 //   Returns cctNNNNMMMM\n where NNNN and MMMM are V then I 0000 to 1023

 // @frqNNNN Sets Sine Oscillator frequency constant 4 through 50
 //   Returns nothing
 //   f = 963.234/NNNN

 // @magNNNN Sets Sine Oscillator magnitude constant 25 through 127
 //   Returns nothing
 //   Vpeak is approximately 12.5*NNNN/127

 // @dacNNNN Set PWM value NNNN = 0 to 255 on pin D11
 //   Returns dac\n
 //   PWM Voltage = 5*NNNN/256

//Interface program must sent serial string then parse returned character string for
//the returned value. Returned string is up to 13 characters including the
//cariage return and linefeed. The returned MMMM value begins after the echoed command string. 

#include "TimerOne.h"

// global variables

  int c_count = 0;            //command buffer counter
  char cmd_buf[10];           //serial port input buffer to hold command string
  volatile int cmd_val = 0;   //integer value from command string
  volatile int v0[256],i0[256];  //analog read values
  volatile int a,b;             //oscillator variables
  volatile int oscON, idac;     //oscillator on/off flag
  int fs = 16; //oscillator frequency constant 15 == 60Hz
  int mag = 127*256; //oscillator magnitude 0 to 127
  int analogmux;
  int nmin = 0;   //most negative pwm value for ramp generator
  int pmax = 255; //most positive pwm value for ramp generator
  
//setup initiallizes the i/o pin directions, the serial interface and the ADC  
void setup() {
  int j;
  pinMode(3, OUTPUT);   //pwm waveform output
  pinMode(11, OUTPUT);  //step generator output
  analogWrite(3,128);  //set the output to mid scale or 0V
  analogWrite(11,0);  //set the output to 0V
  TCCR2B =TCCR2B & B11111000 | B00000001;  //set the PWM frequency to 31Khz
  _SFR_BYTE(ADCSRA) &= 0xFE; //double the ADC clock frequency (~20KHz sample rate)
  Serial.begin(115200); 
  a=0;
  b=mag;
  oscON = 0;
  idac = 0;
  Timer1.initialize(165);         // initialize timer1, and set a 1/2 second period
  Timer1.attachInterrupt(callback);  // attaches callback() as a timer overflow interrupt
  
}

//main read, display and control loop 5Hz
void loop() {
 char c;

//This section scans the serial input string for a command string 
//The three letter command is saved in the global variable
//cmd_buf[] as a null terminated string
 while (Serial.available() != 0) {  //if a character is available, process it
  c = Serial.read();                //get one character
  if (c == '@') {
    c_count = 0;                    //reset to command start
    cmd_val = 0;
    cmd_buf[0] = 0;
    break;
  }  
  cmd_buf[c_count] = c;             //put the character in the command array
  c_count++;
  if ((c == 13) || (c == 10)){      //if end of line characters go
    fndCmd();                       //look for a command string
                                    //and process it
    c_count = 0;                    //reset the command string buffer
    cmd_val = 0;
    cmd_buf[0] = 0;
    break;
  }  
  if (c_count <= 3) {               //after reading three command characters
   if (c_count == 3) {              //read up to four integer characters
    cmd_buf[c_count] = 0;           //initiallize command integer to zero
    cmd_val = 0;
    c_count++;
   }
  }
 //This section extracts 4-digit integer from input string
 //The value is available in global variable cmd_val 
  if (c_count > 4){   
    cmd_val = cmd_val * 10 + int(c-'0');
    if (c_count >= 8) {                 //only read 3 char then 4 integers
     fndCmd();
     c_count = 0;
     cmd_val = 0;
     cmd_buf[0] = 0;
    } 
  }  
 }
}

//routine to search input string for measure command
//other 3-character commands with integer input can be added
//for additional functions
void fndCmd() {
  int i;

   //process dac which is dac command followed by 0000 to 4095 12-bit value  
   if ((cmd_buf[0] == 'd') && (cmd_buf[1] == 'a') && (cmd_buf[2] == 'c')) {
    if (cmd_val > 256) cmd_val = 256;     //dac limits 0-4095    
    analogWrite(11,cmd_val);
    Serial.println("dac");
   }
  
  //Process ADC measure for ADC channel A0 through A5
  //Output is integer 0000 to 1023 (0 to 5V)
  if ((cmd_buf[0] == 'a') && (cmd_buf[1] == 'd') && (cmd_buf[2] == 'c')) {
     if (cmd_val >5) cmd_val = 5;     //adc ports are 0 to 11    
     Serial.print("ad");
     Serial.print(char(cmd_val + 65));   //return A-F for channels 0-5
     if (cmd_val == 0) analogmux = A0;
     if (cmd_val == 1) analogmux = A1;
     if (cmd_val == 2) analogmux = A2;
     if (cmd_val == 3) analogmux = A3;
     if (cmd_val == 4) analogmux = A4;
     if (cmd_val == 5) analogmux = A5;
     v0[0] = analogRead(analogmux);
     inttostr(v0[0]);
     Serial.println();
   }  

 //Process component curve trace with negative to positive ramp
 //Output is integer 0000 to 1023 (-12.6 to 12.6V) and 0000 to 1023 (-5 to 5mA)
  if ((cmd_buf[0] == 'm') && (cmd_buf[1] == 'e') && (cmd_buf[2] == 'a')) {
      oscON = 0;
      analogWrite(3,nmin);
      delay(50);
      analogRead(0);
      for (i=0;i<=255;i++){
       analogWrite(3,nmin + ((pmax-nmin)*i)/255); 
       delayMicroseconds(789);
       v0[i] = analogRead(A2);
       i0[i] = analogRead(A0);       
      }    
      analogWrite(3,128);      
      for (i=0;i<=255;i++){
       Serial.write("mea"); 
       inttostr(v0[i]);
       inttostr(i0[i]);
       Serial.println();
      }
   }  

  //Process component curve trace with continous Sine wave
  //Output is integer 0000 to 1023 (-12.6 to 12.6V) and 0000 to 1023 (-5 to 5mA)
  if ((cmd_buf[0] == 'c') && (cmd_buf[1] == 'c') && (cmd_buf[2] == 't')) {
      if (oscON == 0){
        oscON = 1;
       delay(100);
      }
      while (b < 0);     //sync on waveform generator
      while (b >= 0);                
      for (i=0;i<=255;i++){    //get 256 readings
       i0[i] = analogRead(A0);
       v0[i] = analogRead(A2);
      }

     for (i=0;i<=255;i++){    //send 256 data pairs
      Serial.print("cct");
      inttostr(v0[i]);
      inttostr(i0[i]);
      Serial.println();
      }

   }  

   //process oscillator on/off
   if ((cmd_buf[0] == 'o') && (cmd_buf[1] == 's') && (cmd_buf[2] == 'c')) {
   i = 0;
   oscON = cmd_val;
   } 

 //Process component curve trace with zero to positive ramp
 //Output is integer 0000 to 1023 (-12.6 to 12.6V) and 0000 to 1023 (-5 to 5mA)
  if ((cmd_buf[0] == 'p') && (cmd_buf[1] == 'o') && (cmd_buf[2] == 's')) {
   if (cmd_val > 255) cmd_val = 255;
   pmax = cmd_val;
   if (pmax < nmin) nmin = pmax;
  }    

 //Process component curve trace with zero to negative ramp
 //Output is integer 0000 to 1023 (-12.6 to 12.6V) and 0000 to 1023 (-5 to 5mA)
  if ((cmd_buf[0] == 'n') && (cmd_buf[1] == 'e') && (cmd_buf[2] == 'g')) {
    if (cmd_val > 255) cmd_val = 255;
   nmin = cmd_val;
   if (nmin > pmax) pmax = nmin;
  }

   //set oscillator frequency constant 4 to 50
   if ((cmd_buf[0] == 'f') && (cmd_buf[1] == 'r') && (cmd_buf[2] == 'q')) {
    if (cmd_val < 4) cmd_val = 4;
    if (cmd_val > 50) cmd_val = 50;
    oscON = 0;
    a=0;
    b=mag;
    fs = cmd_val;
    oscON = 1;
   } 

   //set oscillator magnitude 25 to 127 (about 2.4V peak to 12.5V peak)
   if ((cmd_buf[0] == 'm') && (cmd_buf[1] == 'a') && (cmd_buf[2] == 'g')) {
    if (cmd_val < 25) cmd_val = 25;
    if (cmd_val >127) cmd_val = 127;
    oscON = 0;
    a=0;
    b=cmd_val*256;
    mag = cmd_val*256;
    oscON = 1;
   }   
}  

//routine to convert integer to four ascii characters 0000-9999
//easier to generate leading zeros for fixed ouput format
void inttostr(int iv) {
   char c[4];
     c[3] = (iv % 10) + '0';
	 iv = iv / 10;
	 c[2] = (iv % 10) + '0';
	 iv = iv / 10;
	 c[1] = (iv % 10) + '0';
	 iv = iv / 10;
	 c[0] = (iv % 10) + '0';
	 iv = iv / 10;
     Serial.print(c[0]);
     Serial.print(c[1]);
     Serial.print(c[2]);
     Serial.print(c[3]);
} 

void callback()   //sine oscillator interupt routine
{
  if (oscON != 0){
    a = a + b/fs;         //dual integrator oscillator
    b = b - a/fs;
   analogWrite(3,a/256+128); //write the PWM sine value 0-255
  }  
}
