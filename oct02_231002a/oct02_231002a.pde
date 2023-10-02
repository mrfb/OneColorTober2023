// OneColorTober 20231002
// shifting grass

int frames = 250;
float progress = 0;
color c = #ffbf00;

void setup(){
  noiseSeed(20231001);
  size(1024, 1024);
  noSmooth();
  rectMode(CENTER);
  background(255);
}

void draw(){
  background(255);
  
  // recalculate each frame for accuracy
  progress = float(frameCount)/float(frames);
  
  // variable grid that fills the interior
  float gridStep = height * 0.01; // assume square composition
  for(float y = height * .25; y <= height * 0.75; y += gridStep){
    for(float x = width * .25; x <= width * 0.75; x += gridStep){
      wavyGrass(x, y);
    }
  }
  
  if(frameCount <= frames){
    saveFrame("frames/####.png");
    if(frameCount == frames){
      println("done!");
    }
  }
}

// draw a little guy and rotate it using noise
void wavyGrass(float x, float y){
  // noise is based on a circle centered on x,y
  float noiseScale = 1.0/256;
  PVector sampleOffset = PVector.fromAngle(TAU * progress);
  float sampleRadius = width / 256;
  float drawRadius = width / 8;
  sampleOffset.mult(sampleRadius);
  
  resetMatrix();
  translate(x, y);
  
  float adjust = noise((x + sampleOffset.x + 100) * noiseScale,
                       (y + sampleOffset.y + 100) * noiseScale) * 2 - 1;
  
  float altAdjust = noise((y + sampleOffset.y + 100) * noiseScale,
                       (x + sampleOffset.x + 100) * noiseScale) * 2 - 1;
  
  stroke(c);
  fill(c);
  
  // warp the grid a little and add a secondary motion
  translate(adjust * width / 8, altAdjust * width / 8);
  
  circle(0, -1, 0); // round the base a bit
  
  float manualOffset = TAU/1.9; // looks best to me for this seed
  rotate(adjust * TAU + manualOffset);
  
  strokeWeight(2);
  line(0, 0, 0, drawRadius);
  
  strokeWeight(1);
  line(0, 0, 0, drawRadius + 2); // sharpen the far edge a bit
  
}
