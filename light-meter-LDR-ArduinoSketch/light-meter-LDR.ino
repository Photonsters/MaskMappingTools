//reference source: https://www.c-sharpcorner.com/UploadFile/d15fb8/ldr-with-arduino/

int LDR=A0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int lightMeter = analogRead(LDR);
  Serial.println(lightMeter);
  delay(800);
}
