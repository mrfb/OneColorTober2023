// OneColorTober 20231015
// arcs
// rework of 20231001

int frames = 512;
float progress = 0;
color col = #4826E0;
boolean saveFrames = true;

void setup(){
  size(1024, 1024);
  noSmooth();
  rectMode(CENTER);
  stroke(col);
  noFill();
}

void draw(){
  background(255);
  strokeWeight(3);
  
  // recalculate each frame for accuracy
  progress = float(frameCount)/float(frames);
  
  for(float y = height * .25; y <= height * 0.75; y += height * 0.0625){
    for(float x = width * .25; x <= width * 0.75; x += width * 0.0625){
      weathervane(x, y);
    }
  }
  
  if(frameCount <= frames && saveFrames){
    saveFrame("frames/####.png");
    if(frameCount == frames){
      println("done!");
    }
  }
}

// draw a little guy and rotate it using noise
void weathervane(float x, float y){
  // noise is based on a circle centered on x,y
  float noiseScale = 1 / 64.0;
  PVector sampleOffset = PVector.fromAngle(TAU * progress);
  float sampleRadius = width / 32.0;
  sampleOffset.mult(sampleRadius);
  
  resetMatrix();
  translate(x, y);
  
  PVector samplePoint = new PVector(x + sampleOffset.x, y + sampleOffset.y);
  
  float adjust = noise(samplePoint.x * noiseScale,
                       samplePoint.y * noiseScale);
  adjust = map(adjust, 0, 1, -TAU*2, TAU*2);
  
  //circle(0, 0, 6);      // center hinge
  
  rotate(adjust + (x+y)*.03);
  float radius = width / 16.0;
  arc(0, 0, radius, radius, TAU * -.125, TAU * .125);
  //line(-16, 0, 12, 0);  // shaft
  //fill(255);
  //circle(-16, 0, 12);   // weight
  //point(-16, 0);
  //line(12, 6, 12, -6);  // head
  //line(16, 4, 16, -4);
  //line(20, 2, 20, -2);
  //point(24, 0);
}
