#include <CapacitiveSensor.h>

int ledPin = 3;
byte brightnessMax = 50;
byte brightnessStepping = 10; 
byte brightness = 0;
long threshold = 300;
long plusSensorValue = 0;
long minusSensorValue = 0;


int plusSendPin = 12; //attached to resistor
int plusReceivePin = 10;
int minusSendPin = 8; //attached to resistor
int minusReceivePin = 6;
CapacitiveSensor plusButton = CapacitiveSensor(plusSendPin, plusReceivePin);
CapacitiveSensor minusButton = CapacitiveSensor(minusSendPin, minusReceivePin);


void setup() 
{
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT); 
}

void loop(){
  plusSensorValue = plusButton.capacitiveSensor(30);
  minusSensorValue = minusButton.capacitiveSensor(30);

  //Serial.print("minus: ");
  //Serial.print(minusSensorValue);
  //Serial.print(" | plus: ");
  //Serial.print(plusSensorValue);
  //Serial.print("\t Current brightness: ");
  //Serial.print(brightness);
  //Serial.print("\n");

  if(!(plusSensorValue > threshold && minusSensorValue > threshold) &&
     (plusSensorValue > threshold || minusSensorValue > threshold)){
    //Serial.print("Old brightness: ");
    //Serial.print(brightness);

    if(plusSensorValue > threshold)
      increaseBrightness();
      //Serial.print(plusSensorValue); 
      //Serial.print("\n");
    if(minusSensorValue > threshold)
      decreaseBrightness();
      //Serial.print(minusSensorValue);
      //Serial.print("\n");
  	Serial.print(brightness);

    //Serial.print("\t New brightness: ");
    //Serial.print(brightness);
    //Serial.print("\n");   
  }
  delay(500);
}

void increaseBrightness(){
    if(brightness < brightnessMax){
      brightness = brightness + brightnessStepping;
      if(brightness > brightnessMax)
        brightness = brightnessMax;
      setBrightness(brightness);
    }
}

void decreaseBrightness(){
    if(brightness > 0){
      brightness = brightness - brightnessStepping;
      if(brightness < 0)
        brightness = 0;
      setBrightness(brightness);
    }
}

void setBrightness(byte brightness) // 0 to 255
{
  analogWrite(ledPin, brightness);
}