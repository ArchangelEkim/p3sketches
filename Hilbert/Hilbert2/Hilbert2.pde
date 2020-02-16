
int order;
int N;
int total;

PVector[] path;
PImage img;

boolean recording = false;

void setup() {
  size(1024, 1024);
  img = loadImage("colorlights.jpg");
  background(0);
  //colorMode(HSB, 360, 255, 255);
  order = 7;
  N = int(pow(2, order));
  total = N * N;
  path = new PVector[total];
  for(int i = 0; i < total; i++){
    path[i] = hilbert(i);
    float len = width/N;
    path[i].mult(len);
    path[i].add(len/2, len/2);
  }
}

void keyPressed() {
  if(key == 'r' || key == 'R') {
    recording = !recording;
  }
}

int counter = 0;
int oldOrder = order;
int i = 1;
void draw() {
    
  if(i >= total) {
    i = 1;
  }

  int pixelIndex = (int) (path[i].x + path[i].y * img.width);
  color pixelColor = img.pixels[pixelIndex];
  stroke(red(pixelColor), green(pixelColor), blue(pixelColor));
  line(path[i-1].x, path[i-1].y, path[i].x, path[i].y);
  if(i % 10 == 0) {
    saveFrame("output/7/frame_#####.png");
  }
  i++;
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
    
    float len = pow(2, j);
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
