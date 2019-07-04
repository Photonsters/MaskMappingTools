// This is a light map meter helper tool, designed for the LCD resin printer Anycubic Photon, but can be used with any other LCD printer
// It uses a simples serial read from any capable device configured to send a serial print trough it's com. 

// TODO:
// Add reset button
// Add on the fly node nr configuration(preset as photon grid)
// Add Photonsters logo and branding
// Add export to CSV capability
// Add import CSV capability (Not important)


String serialRead = "no data";
int marginx = 200;
int marginy = marginx;
int gxpos = marginx/2;
int gypos = marginy/2;
int xnodesnr = 10;
int ynodesnr = 6;
int xynodespacing = 5;

//gridNode gn0 = new gridNode(100,100,200,100,serialRead);
//gridNode gn1 = new gridNode(100,100,310,100,serialRead);

gridBlock gb1;
gridNode btnrst;
gridNode btnsave;

void setup(){
  
  clear();
  size(1000, 800);
  frameRate(30);
  
  // Build com chooser interface
  comSetup(0,0);
  
  // Instatiate grid
  gb1 = new gridBlock(width-marginx, height-marginy, gxpos, gypos, xnodesnr, ynodesnr, xynodespacing);
  
  // Build grid
  gb1.build();
  
  btnsave = new gridNode(100,50,101,0,"Save");
  btnsave.nRGB = color(60, 60, 60);
  btnsave.tnRGB = color(255, 255, 255);
  btnsave.onRGB = color(0, 116, 217);
  
  btnrst = new gridNode(100,50,202,0,"Reset");
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
  
  //gn0.update();
  //gn0.ntxt = trim(serialRead);
  //gn1.update();
  //gn1.ntxt = trim(serialRead);
  
  //gb1.nodes[0][0].update();
  //gb1.nodes[0][1].update();
  //gb1.nodes[1][0].update();
  //gb1.nodes[1][1].update();
  
  gb1.update();
  btnrst.update();
  btnsave.update();
} 

void mouseReleased(){
  //gn0.onclick();
  //gn1.onclick();
 
  //gb1.nodes[0][0].onclick();
  //gb1.nodes[0][1].onclick();
  //gb1.nodes[1][0].onclick();
  //gb1.nodes[1][1].onclick();
  
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
