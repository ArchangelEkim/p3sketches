import processing.pdf.*;

float angle = 0.1;
int len = 20;


void setup() {
  size(1200,720);
  beginRecord(PDF, "CollatzGraph.pdf");
  background(255);
  stroke(0, 50);
  fill(0);
  translate(width/2, height);
  collatzLeaf(0,1);
}

void draw() {
  endRecord();
}

void collatzLeaf(int depth, int n) {
 if(depth < 31){
  int possibleLeaf = n * 2;
  pushMatrix();
  println("Branching Left");
  rotate(-angle*0.8);
  line(0,0,0,-len);
  translate(0,-len);
  //text("" + possibleLeaf, 0,0);
  collatzLeaf(depth+1, possibleLeaf);
  popMatrix();
  
  possibleLeaf = (n - 1)/3;
  if((n - 1) % 3 == 0 && possibleLeaf > 1 ) {
    pushMatrix();
    println("Branching Right");
    rotate(5*angle);
    line(0,0,0,-len);
    translate(0,-len);
    //text("" + possibleLeaf, 0,0);
    collatzLeaf(depth+1, possibleLeaf);
    popMatrix();
  }
 }
 
}
