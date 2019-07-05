// MakerMatrix, 2019
// https://www.youtube.com/channel/UCmzG8TnncnbLBt5bfQoGR-Q
// X3msnake's reference for LDR setup: https://www.c-sharpcorner.com/UploadFile/d15fb8/ldr-with-arduino/
// Smoothing implemented from ideas at https://www.arduino.cc/en/Tutorial/Smoothing

int LDR=A0;                  // Install LDR signal at pin A0
int sampleDelay = 50;        // Sample every 50ms - any faster than this causes buffering and lag at the client
const int windowSize = 25;   // Smooth over a window of 25 samples
int LDRcache[windowSize], total, mean, i;

void setup() {
  
  Serial.begin(57600);
  total = mean = 0;
  
  // Let's average out some noise - start by collecting windowSize number of samples
  for( i=0; i<windowSize; i++){
    LDRcache[i] = analogRead(LDR);
    total += LDRcache[i];
    delay(sampleDelay);
  }
  
  // Compute the mean of that window and send it...
  mean = total/windowSize;
  Serial.println(mean);
  
}

void loop() {
  
  // To continue smoothing the data we now continuously loop over the cached LDR values
  // and replace the oldest one with the latest sample.  Then compute a new mean.
  for( i=0; i<windowSize; i++){
     total -= LDRcache[i];          // Subtract the oldest cached value from total
     LDRcache[i] = analogRead(LDR); // Replace it with a new measurement;
     total += LDRcache[i];          // Add the newest measurement to total
     mean = total/windowSize;       // Compute the new mean
     Serial.println(mean);          // Send it
     delay(sampleDelay);            // Wait for the next sample...
  }
  
}
