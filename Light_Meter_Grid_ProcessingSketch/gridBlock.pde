// Define a grid made of node instances

class gridBlock {
  
  // Set grid properties, with, height, nr of nodes
  int gxpos, gypos, gw, gh;
  int nxn, nyn;
  int nxpos, nypos, nw, nh, nspc;
  gridNode[][] nodes;

  // Class constructor initiate instance
  gridBlock (int w, int h, int x, int y, int nodexnr, int nodeynr, int nodespacing){
    
    gxpos = x;
    gypos = y;
    gw = w;
    gh = h;
    nxn = nodexnr;
    nyn = nodeynr;
    nspc = nodespacing;
    // nxpos = gxpos;
    // nypos = gypos;
    nw = round(gw / nxn - nspc);
    nh = round(gh / nyn - nspc);
    nodes = new gridNode[nodexnr][nodeynr];
    println(nxpos, nypos, nw, nh);
  
  }
  
  // Calculate node width height
  void setup() {
    
    //nw = w/nxn;
    //ny = h/nyn;
    
  }
  
  // Create a grid
  void build() {         
    for (int i=0; i<nxn; i++) {
      for (int j=0; j<nyn; j++) {
        
        nxpos = i*(nw+nspc)+gxpos+nspc/2;
        nypos = j*(nh+nspc)+gypos+nspc/2;
        nodes[i][j] = new gridNode(nw, nh, nxpos, nypos );
        // println(nxpos, nypos, nxpos+nw, nypos+nh);
        
      }
    }
 }
 // Redraw grid nodes
 void update(){
   
     for (int i=0; i<nxn; i++) {
      for (int j=0; j<nyn; j++) {
        nodes[i][j].update();
        nodes[i][j].ntxt = trim(serialRead);
      }
     }
 }
  // Export
 void export2csv(String path){
   
   Table table = new Table();
   
   for (int i=0; i<nxn; i++) {
     table.addColumn();
   }
   for (int j=0; j<nyn; j++) {
     table.addRow();
   }
     
     for (int i=0; i<nxn; i++) {       
       for (int j=0; j<nyn; j++) {
        table.setString(j, i, nodes[i][j].ntxtFrozen);
        println(nodes[i][j].ntxtFrozen);
        
      }
     }
     
     saveTable(table, path);
 }
 // Calculate mouse actions
 void onclick(){
     for (int i=0; i<nxn; i++) {
      for (int j=0; j<nyn; j++) {
        nodes[i][j].onclick();
      }
     }
 }
}