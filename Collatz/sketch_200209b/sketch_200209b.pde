import processing.pdf.*;

float angle = 0.1;
int len = 10;
IntList sequence = new IntList();

void setup() {
  size(1920,1080);
  //beginRecord(PDF, "CollatzGraph3.pdf");
  background(255);
  stroke(0, 25);
  strokeWeight(2);
  for(int i = 1; i < 5000; i++){
    resetMatrix();
    translate(width/2, height/2);
    int n = i;
    while( n != 1) {
      n = collatz(n);
      sequence.append(n);
    }
    sequence.reverse();
    float usedLen = len;
    for(int num : sequence) {
      if (num % 2 == 0){
        rotate(0.5* (float)Math.log(2));
        line(0,0,0,-usedLen);
        translate(0,-usedLen);
      } else {
        rotate(0.7* (float)-Math.log(3));
        line(0,0,0,-usedLen);
        translate(0,-usedLen);
      }
      usedLen = (float) Math.pow(usedLen, 0.999);
    }
    sequence.clear();
  }
}

void draw() {
  //endRecord();
}

int collatz(int n) {
  if(n%2 == 0){
    return n/2;
  } else {
    return n*3 + 1;
  }
}
