// 20231006
// ocean horizon

color c = #90D0FA;

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
  
  arc(width*.5, height*.5, width*.125, width*.125, TAU*.5, TAU);
  
  pushMatrix();
  translate(width*.5 + 0, height*.5);
  for(int i = 4; i < 317; i += 4){
    // main line set
    float offset = -10;
    float start = sin(progress*TAU + i/4.0)*258;
    float end = 8;
    line(start - i + offset, i, start+end+i + offset, i);
    
    // alternate set
    offset = -13;
    start = sin(progress*TAU + i/6.6)*285;
    end = 8;
    line(start - i + offset, i, start+end+i + offset, i);
    
    // highlights
    stroke(255);
    offset = 5;
    start = sin(progress*TAU + i/2.0)*84;
    end = -2;
    line(start - i/4.0 + offset, i, start+end+i/4.0 + offset, i/1.1);
    stroke(c);
  }
  popMatrix();
  
  // put a bird on it
  pushMatrix();
  birdFloat(672, 398);
  birdFloat(972, 326);
  birdFloat(659, 416);
  popMatrix();
  //PVector anchor = new PVector(644, 398);
  
  //translate(anchor.x, anchor.y);
  //PVector adjust = new PVector((anchor.x + cos(progress*TAU)*32)*.003,
  //                             (anchor.y + sin(progress*TAU)*32)*.003);
  
  //translate(adjust.x, adjust.y);
  
  //float drift = map(noise(adjust.x, adjust.y), 0, 1, -1, 1);
  //rotate(drift * TAU/16.0);
  //line(0, 0, -16 - cos(progress*TAU) * 4, -16 + sin(progress*TAU) * 4); // left wing
  ////rotate();
  //line(0, 0, 16 + cos(progress*TAU) * 4, -16 + sin(progress*TAU) * 4); // right wing
  
  
  
  // matte and outline
  noStroke();
  fill(255);
  rect(0, 0, width, height*.25);
  rect(0, 0, width*.25, height);
  rect(0, height*.75, width, height*.25);
  rect(width*.75, 0, width*.25, height);
  
  noFill();
  stroke(c);
  square(width*.25, height*.25, width*.50);
  
  if(frameCount <= frameEnd){
    saveFrame("frames/####.png");
    if(frameCount == frameEnd) println("done!");
  }
}

void birdFloat(float x, float y){
  // noise is based on a circle centered on x,y
  float noiseScale = 1.0/256;
  PVector sampleOffset = PVector.fromAngle(TAU * progress);
  float sampleRadius = width / 511;
  float drawRadius = 1038;
  sampleOffset.mult(sampleRadius);
  
  resetMatrix();
  translate(x, y);
  
  float adjust = noise((x + sampleOffset.x + 100) * noiseScale,
                       (y + sampleOffset.y + 100) * noiseScale) * 2 - 1;
  
  float altAdjust = noise((y + sampleOffset.y + 1024) * noiseScale,
                       (x + sampleOffset.x + 1024) * noiseScale) * 2 - 1;
  
  stroke(c);
  fill(c);
  
  // warp the grid a little and add a secondary motion
  translate(adjust * drawRadius, altAdjust * drawRadius);
  
  //circle(0, -1, 0); // round the base a bit
  
  //float manualOffset = TAU/1.9; // looks best to me for this seed
  rotate(adjust * TAU / 27.9);
  
  //frame[0].strokeWeight(2);
  line(0, 0, -16, -8);
  line(0, 0, 16, -8);  
}
