// OneColorTober 20231001
// magnetic weathervanes

int frames = 100;
float progress = 0;

void setup(){
  size(1024, 1024);
  noSmooth();
  rectMode(CENTER);
}

void draw(){
  background(255);
  strokeWeight(3);
  
  // recalculate each frame for accuracy
  progress = float(frameCount)/float(frames);
  
  // 9x9
  for(float y = height * .25; y <= height * 0.75; y += height * 0.0625){
    for(float x = width * .25; x <= width * 0.75; x += width * 0.0625){
      weathervane(x, y);
    }
  }
  
  if(frameCount <= frames){
    saveFrame("frames/####.png");
  }
}

// draw a little guy and rotate it using noise
void weathervane(float x, float y){
  // noise is based on a circle centered on x,y
  float noiseScale = 0.0050;
  PVector sampleOffset = PVector.fromAngle(TAU * progress);
  float sampleRadius = width * 0.0625;
  sampleOffset.mult(sampleRadius);
  
  resetMatrix();
  translate(x, y);
  
  PVector samplePoint = new PVector(x + sampleOffset.x, y + sampleOffset.y);
  
  float adjust = noise(samplePoint.x * noiseScale,
                       samplePoint.y * noiseScale) * 2 - 1;
  adjust *= TAU;
  
  circle(0, 0, 6);      // center hinge
  rotate(adjust);
  line(-16, 0, 12, 0);  // shaft
  fill(255);
  circle(-16, 0, 12);   // weight
  point(-16, 0);
  line(12, 6, 12, -6);  // head
  line(16, 4, 16, -4);
  line(20, 2, 20, -2);
  point(24, 0);
}
