// 20231005
// flyers

// this one's a little more disorderly than usual, sorry.

color c = #5F5F1F;

float progress;
int frameEnd = 512;

int numFlyers = 32;
PVector[] anchors;

void setup() {
  size(1024, 1024);
  
  frameRate(50);
  noiseSeed(20231005);
  randomSeed(20231005);
  background(255);
  
  anchors = new PVector[numFlyers];
  for(int i = 0; i < anchors.length; i++){
    anchors[i] = new PVector(random(width*.35, width*.65), random(height*.35, height*.65));
  }
}

void draw() {
  background(255);
  stroke(c);
  
  progress = frameCount / float(frameEnd);
  
  rect(width*.25, height*.25, width*.5, height*.5);
  
  for(int i = 0; i < anchors.length; i++){
    flyer(anchors[i].x, anchors[i].y);
  }
  
  
  //int gridStep = 8;
  //for(int y = 0; y < 50; y += gridStep){
  //  for(int x = 0; x < 50; x += gridStep){
  //    flyer(x + 500, y + 500);
  //  }
  //}
  
  
  
  if(frameCount <= frameEnd){
    saveFrame("frames/####.png");
  }
  
}


void flyer(float x, float y){
  // noise is based on a circle centered on x,y
  float noiseScale = 1.0/64;
  PVector sampleOffset;
  float sampleRadius = width / 128;
  float drawRadius = 256;
  
  // calculate the positions of each of the segments
  PVector[] positions = new PVector[10];
  for(int i = 0; i < positions.length; i++){
    int segmentDistance = 8;
    sampleOffset = PVector.fromAngle(TAU * (frameCount + i*segmentDistance) / float(frameEnd));
    sampleOffset.mult(sampleRadius);
    float adjust = noise((x + sampleOffset.x + 512) * noiseScale, (y + sampleOffset.y + 512) * noiseScale);
    float altAdjust = noise((y + sampleOffset.y + 1024) * noiseScale, (x + sampleOffset.x + 1024) * noiseScale);
    adjust = map(adjust, 0, 1, -1, 1);
    altAdjust = map(altAdjust, 0, 1, -1, 1);
  
    positions[i] = new PVector(adjust * drawRadius * 1, altAdjust * drawRadius);
  }
  
  stroke(c);
  strokeWeight(1);
  
  for(int i = 0; i < positions.length; i++){
    int wingSpan = 1;
    resetMatrix();
    translate(x, y);
    translate(positions[i].x, positions[i].y);
    line(-wingSpan * log(i), 0, wingSpan * log(i), 0);
  }
  
  
  //strokeWeight(1);
  //line(0, 0, 0, drawRadius + 2); // sharpen the far edge a bit
  
}
