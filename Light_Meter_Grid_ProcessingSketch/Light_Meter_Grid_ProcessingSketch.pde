// This is a light map meter helper tool, designed for the LCD resin printer Anycubic Photon, but can be used with any other LCD printer
// It uses a simples serial read from any capable device configured to send a serial print trough it's com. 

// TODO:
// Add on the fly node nr configuration(preset as photon grid)
// Add Photonsters logo and branding
// Add import CSV capability (Not important)


String serialRead = "No Data";
int baudRate = 57600;
int marginx = 100;
int marginy = 150;
int gxpos = 75;
int gypos = 125;
int xnodesnr = 11;
int ynodesnr = 6;
int xynodespacing = 5;

gridBlock gb1;
gridNode btnrst;
gridNode btnsave;

void setup(){
  
  clear();
  size(1100, 700);
  frameRate(30);
  textSize(30);
  fill( 255, 255, 255);
  text("Waiting to communicate with Uno board...", marginx, height/2);
  delay(1500);
  
  // Build com chooser interface
  comSetup(0,0);
  
  // Instatiate grid
  gb1 = new gridBlock(width-marginx, height-marginy, gxpos, gypos, xnodesnr, ynodesnr, xynodespacing);
  
  // Build grid
  gb1.build();
  
  btnsave = new gridNode(100,50,101,0,"Save",false);
  btnsave.nRGB = color(60, 60, 60);
  btnsave.tnRGB = color(255, 255, 255);
  btnsave.onRGB = color(0, 116, 217);
  
  btnrst = new gridNode(100,50,202,0,"Reset",false);
  btnrst.nRGB = color(60, 60, 60);
  btnrst.tnRGB = color(255, 255, 255);
  btnrst.onRGB = color(0, 116, 217);
}

void draw(){ 
  
  background(204);
  noStroke();
  fill(30,30,30);
  rect(0, 0, width, 50);
  
  // Detect mouse over com interface
  comMouse();
  
  gb1.update();
  btnrst.update();
  btnsave.update();
} 

void mouseReleased(){
  
  gb1.onclick();
  btnrst.onclick();
  btnsave.onclick();
  
  if (btnrst.nodeFrozen){
    gb1.build();
    btnrst.nodeFrozen = false;
  }
    if (btnsave.nodeFrozen){
      File filename = new File("PhotonLightMap.csv");
      selectOutput("Select a folder to save:", "fileSelected", filename );
      btnsave.nodeFrozen = false;
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    gb1.export2csv(selection.getAbsolutePath());
  }
}
