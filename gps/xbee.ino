#include <SoftwareSerial.h>
SoftwareSerial xBeeSerial(10, 11); // 10 in : 11 out

char incomingChar;

void setup() {
  Serial.begin(9600);
  xBeeSerial.begin(9600);
}

void loop() {
  if (xBeeSerial.available() > 0) {
    incomingChar = xBeeSerial.read();

    Serial.print(incomingChar); 
  }
}
