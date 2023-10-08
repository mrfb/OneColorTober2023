// 20231007
// 

color c = #FA90A3;

float progress;
int frameEnd = 512;

void setup() {
  size(1024, 1024);
  
  frameRate(50);
  noiseSeed(20231006);
  randomSeed(20231006);
  noSmooth();
  
  background(255);
}

void draw() {
  background(255);
  stroke(c);
  
  progress = frameCount / float(frameEnd);
  
  noFill();
  square(width*.25, height*.25, width*.50);
  
  if(frameCount <= frameEnd){
    saveFrame("frames/####.png");
  }
}
