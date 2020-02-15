
PImage david;

int range = 15;

void setup(){
 size(1500, 985);
 david = loadImage("david.jpg");
 //david.filter(GRAY);
 image(david, 0,0);
 
 david.loadPixels();
 //int maxIndex = index(david.width-1, david.height);
 for(int y = 0; y < david.height-1; y++){
   for(int x = 0; x < david.width-1; x++){
     color oldpixel = david.pixels[index(x,y)];
     color newpixel = findClosestPaletteColor(oldpixel);
     david.pixels[index(x,y)] = newpixel;
     color quant_error = error(oldpixel, newpixel);
     david.pixels[index(x+1,   y)] = fsDither(david.pixels[index(x+1,   y)], quant_error, 7 / 16.0);
     david.pixels[index(x-1, y+1)] = fsDither(david.pixels[index(x-1, y+1)], quant_error, 3 / 16.0);
     david.pixels[index(  x, y+1)] = fsDither(david.pixels[index(  x, y+1)], quant_error, 5 / 16.0);
     david.pixels[index(x+1, y+1)] = fsDither(david.pixels[index(x+1, y+1)], quant_error, 1 / 16.0);
   }
 }
 david.updatePixels();
 image(david, 750,0);
 david.save("davidDithered.png");
}

void draw(){
  
}

int index(int x, int y){
 return x + y * david.width; 
}

color findClosestPaletteColor(color oldpixel){
  float oldR = red(oldpixel);
  float oldG = green(oldpixel);
  float oldB = blue(oldpixel);
  
  int newR = round(range * oldR / 255) * (255 / range);
  int newG = round(range * oldG / 255) * (255 / range);
  int newB = round(range * oldB / 255) * (255 / range);
  return color(newR, newG, newB);
}

color error(color oldPixel, color newPixel) {
  float oldR = red(oldPixel);
  float oldG = green(oldPixel);
  float oldB = blue(oldPixel);
  
  float newR = red(newPixel);
  float newG = green(newPixel);
  float newB = blue(newPixel);
  
  float errR = oldR - newR;
  float errG = oldG - newG;
  float errB = oldB - newB;
  
  return color(errR, errG, errB);
}

color fsDither(color pixel, color error, float multiplier){
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);
  
  float errR = red(error);
  float errG = green(error);
  float errB = blue(error);
  
  float fixedR = r + errR * multiplier;
  float fixedG = g + errG * multiplier;
  float fixedB = b + errB * multiplier;
  
  return color(fixedR, fixedG, fixedB);
}
