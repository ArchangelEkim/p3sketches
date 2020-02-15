
float PHI = 2*PI * 0.61803398875;
float len = 1;
float increment;
float angle;

void setup() {
  size(720,720);
  noLoop();
  angle = PHI;
  increment = 0.01;
}

void draw() {
  background(0);
  resetMatrix();
  translate(width/2, height/2);
  //text("Angle: " + angle,-width/2,0);
  len = 0.1;
  for(int i = 0; i < 10000; i++) {
    fill( abs(sin(angle)) * 255 * len % 255, abs(cos(angle)) * 255, abs(tan(angle) * 255) * len %255);
    circle(0, len, 5);
    rotate(angle);
    len += 0.1;
  }
  if(angle > 2* PI || angle < 0) { increment *= (-1);}
  angle += increment;
  
}
