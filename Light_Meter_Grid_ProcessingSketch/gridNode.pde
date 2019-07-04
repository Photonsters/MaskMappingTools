// Define the node class

class gridNode {
 
    int nx;
    int ny;
    int nw;
    int nh;
    int nxh;
    int nyh;
    int nwh;
    int nhh;
    boolean mouseOver;
    boolean nodeFrozen;
    String ntxt;                             // Normal text to display
    String ntxtFrozen;                       // Frozen text to display
    color nRGB = color(255,255,255);         // Normal color
    color onRGB = color(125,125,255);        // Over Normal color 
    color fRGB = color(125,125,125);         // Frozen color
    color ofRGB = color(150,150,150);        // Over Frozen color
    color tnRGB = color(125,125,125);        // Text Normal color
    color tonRGB = color(255,255,255);       // Text Over Normal color 
    color tfRGB = color(255,255,255);        // Text Frozen color
    color tofRGB = color(255,255,255);       // Text Over Frozen color
  
  gridNode(int w, int h, int x, int y, String txt){
    
    nx = x;
    ny = y;
    nw = w;
    nh = h;
    ntxt = txt;
    
  }
  
  gridNode(int w, int h, int x, int y){
    
    nx = x;
    ny = y;
    nw = w;
    nh = h;
    ntxt = "N/A";
    
  }
  
  void update(){   
    
    if (!nodeFrozen){
    ntxtFrozen = ntxt;
    }
      
    if (mousePressed && ismouseOver()){
      //nx = mouseX - nw/2;
      //ny = mouseY - nh/2;
      //ntxt = "Pressed"
      
      if (nxh == 0) {
        nxh = nx;
        nyh = ny;
        nwh = nw;
        nhh = nh;
      } 

      nx = nxh+2;
      ny = nyh+2;
      nw = nwh-4;
      nh = nhh-4;

    }
    // Draw node state 
    
    // Normal
    if (!ismouseOver() && !nodeFrozen){
      fill(nRGB);
      rect(nx, ny, nw, nh);
      txtdrw(tnRGB);
    }
    // OverFrozen
    else if (ismouseOver() && nodeFrozen){
      fill(ofRGB);
      rect(nx, ny, nw, nh);
      txtdrw(tofRGB);
    }
    // Frozen
    else if (nodeFrozen) {
      fill(fRGB);
      rect(nx, ny, nw, nh);
      txtdrw(tfRGB);
    }
    // OverNormal
    else {
      fill(onRGB);
      rect(nx, ny, nw, nh);
      txtdrw(tonRGB);
    }

    //println(nx, mouseX, mouseOver);
    //println(nodeFrozen, ntxtFrozen);
    //println(nodeFrozen, ntxtFrozen);
    
  }
  
  void txtdrw(color txtRGB){
    
    // Draw text
    int tsz = nh/4;
    textSize(tsz);

    textAlign(CENTER, CENTER);
    if (!nodeFrozen){
      fill(txtRGB);
      text(ntxt, nx, ny, nw, nh);
    } else {
      fill(txtRGB);
      text(ntxtFrozen, nx, ny, nw, nh);
    }
  }
  
  void onclick(){
    if (ismouseOver()){
      nodeFrozen = !nodeFrozen;
      nx = nxh;
      ny = nyh;
      nw = nwh;
      nh = nhh;
    }
  }
  
  boolean ismouseOver() {
    return mouseOver = mouseX >= nx && mouseX <= nx+nw && mouseY >= ny && mouseY <= ny+nh;  
  }

}