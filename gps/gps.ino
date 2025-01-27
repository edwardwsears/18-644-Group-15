#include <SoftwareSerial.h>

SoftwareSerial gpsSerial(10, 11); // 10 in : 11 out
//SoftwareSerial xBeeSerial(3, 5);  // 3  in : 5  out
const int sentenceSize = 80;

char sentence[sentenceSize];

void setup()
{
  Serial.begin(9600);
  gpsSerial.begin(9600);
//  xBeeSerial.begin(9600);
}

void loop()
{
  static int i = 0;
  if (gpsSerial.available())
  {
    char ch = gpsSerial.read();
    if (ch != '\n' && i < sentenceSize)
    {
      sentence[i] = ch;
      i++;
    }
    else
    {
      sentence[i] = '\0';
      i = 0;
      displayGPS();
    }
  }
}

void displayGPS()
{
  char field[20];
  
  getField(field, 0);
  if (strcmp(field, "$GPGGA") == 0)
  {
    Serial.print("# Sat: ");
    getField(field, 6);
    Serial.print(field);
  }
  if (strcmp(field, "$GPRMC") == 0)
  {    
    Serial.print(" Lat: ");
    getField(field, 3);  // number
    Serial.print(field);
    getField(field, 4); // N/S
    Serial.print(field);

    Serial.print(" Long: ");
    getField(field, 5);  // number
    Serial.print(field);
    getField(field, 6);  // E/W
    Serial.println(field);
  }
}

void getField(char* buffer, int index)
{
  int sentencePos = 0;
  int fieldPos = 0;
  int commaCount = 0;
  while (sentencePos < sentenceSize)
  {
    if (sentence[sentencePos] == ',')
    {
      commaCount ++;
      sentencePos ++;
    }
    if (commaCount == index)
    {
      buffer[fieldPos] = sentence[sentencePos];
      fieldPos ++;
    }
    sentencePos ++;
  }
  buffer[fieldPos] = '\0';
} 

