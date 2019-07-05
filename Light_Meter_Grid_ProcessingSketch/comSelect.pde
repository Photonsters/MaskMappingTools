// Code by DavidBacelj
// https://forum.processing.org/two/discussion/22898/select-com-port-in-sketch-through-drop-down-list-using-controlp5-and-serial-library
// Null value handling added by MakerMatrix

import processing.serial.*;
import controlP5.*;

ControlP5 cp5;
DropdownList d1;
 
Serial myPort;

String portName;
int serialListIndex;
int nullCounter = 0;
int readCounter = 0;

void comSetup(int px, int py){ 

  cp5 = new ControlP5(this);
 
  PFont pfont = createFont("Arial",10,true); //Create a font
  ControlFont font = new ControlFont(pfont,12); //font, font-size
 
  d1 = cp5.addDropdownList("myList-d1")
          .setPosition(px, py)
          .setSize(100, 200)
          .setHeight(210)
          .setItemHeight(40)
          .setBarHeight(50)
          .setFont(font)
          .setColorBackground(color(60))
          .setColorActive(color(255, 128))
          ;
 
      d1.getCaptionLabel().set("PORT"); //set PORT before anything is selected
 
      // Let's check for available ports before we try to instantiate Serial()
      String[] ports = Serial.list();        //Get a list of available ports
      while( ports.length == 0){             //If none are available, stay in this loop
         //println ("No available ports");         
         delay(1000);
         ports = Serial.list();      //Try again every second until a port is available
      }
      
      portName = Serial.list()[0]; //0 as default
      myPort = new Serial(this, portName, baudRate);

}

void comMouse(){
  
  if(d1.isMouseOver()) {
    d1.clear(); //Delete all the items
    for (int i=0; i<Serial.list().length; i++) {
      d1.addItem(Serial.list()[i], i); //add the items in the list
    }
  }
  
  if ( myPort.available() > 0){                   //read incoming data from serial port
    serialRead = myPort.readStringUntil('\n');
    readCounter++;
    while( serialRead == null){  // Sanity check for null serial values
      nullCounter++;             // Notice and log null, but don't send it
      delay(10);                  // A short delay here minimizes the number of consecutive null reads
      println("Oops, LDR value has been NULL " + nullCounter + " of " + readCounter + " times.");        
      serialRead = myPort.readStringUntil('\n');  // Try again
      readCounter++;
    }
   }
}

void controlEvent(ControlEvent theEvent) { //when something in the list is selected
    myPort.clear(); //delete the port
    myPort.stop(); //stop the port
    if (theEvent.isController() && d1.isMouseOver()) {
    portName = Serial.list()[int(theEvent.getController().getValue())]; //port name is set to the selected port in the dropDownMeny
    myPort = new Serial(this, portName, baudRate); //Create a new connection
    println("Serial index set to: " + theEvent.getController().getValue());
    serialRead = "No Data";
    delay(2000); 
    }
}
