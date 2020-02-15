
int  order = 10;
int  N = int(pow(2, order));
int  total = N * N;

PVector[] path;
PImage startImg;
PImage finalImg;

boolean recording = false;

void setup() {
  size(1024, 1024);
  startImg = loadImage("lake.jpg");
  println(total + "," + startImg.width * startImg.height);
  
  background(0);
  //colorMode(HSB, 360, 255, 255);

  path = new PVector[total];
  for(int i = 0; i < total; i++){
    path[i] = hilbert(i);
    int len = width/N;
    path[i].mult(len);
    path[i].add(len/2, len/2);
  }
  
  finalImg = createImage(N,N,RGB);
  finalImg.loadPixels();
  
  for(int j = 0; j < total; j++){
    try {
    int pixelIndex = (int) (path[j].x + path[j].y * startImg.width);
    finalImg.pixels[j] = startImg.pixels[pixelIndex-1];
    } catch (Exception error) {
      println(path[j].x + "," + path[j].y);
    }
  }
  
  finalImg.updatePixels();
  finalImg.save("lakeHilbert.png");
  
  image(finalImg,0,0);
  
}

void draw() {

}


PVector hilbert(int i) {
  PVector[] points = {
    new PVector(0,0),
    new PVector(0,1),
    new PVector(1,1),
    new PVector(1,0)
  };
  
  int index = i & 3;
  PVector v = points[index];
  
  for(int j = 1; j < order; j++) {
    
    i = i >>> 2;
    index = i & 3;
    
    int len = int(pow(2, j));
    if(index == 0) {
      float temp = v.x;
      v.x = v.y;
      v.y = temp;
    } else if (index == 1) {
      v.y+= len;
    } else if (index == 2) {
      v.x+= len;
      v.y+= len;
    } else if (index == 3) {
      float temp = len - 1 - v.x;
      v.x = len - 1 - v.y;
      v.y = temp;
      v.x+= len;
    }
  }
  
  return v;
}
