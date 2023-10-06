// 20231005
// flyers

color c = #504704;

float progress;
int frameEnd = 512;

int numFlyers = 5;
PVector[] anchors;

void setup() {
  size(1024, 1024);
  
  frameRate(50);
  noiseSeed(20231005);
  randomSeed(20231005);
  background(255);
  noSmooth();
  
  anchors = new PVector[numFlyers];
  for(int i = 0; i < anchors.length; i++){
    anchors[i] = new PVector(random(width*.35, width*.65), random(height*.35, height*.65));
  }
  anchors[1].set(width*.35, height*.15);
}

void draw() {
  background(255);
  stroke(c);
  
  progress = frameCount / float(frameEnd);
  
  translate(width * .75, height * .75);
  rotate(progress*TAU/2);
  for(int i = 0; i < 264; i += 4){
    line(-300,  i, 300, i);
    if(i == 0) continue;
    line(-300, -i, 300, -i);
  }
  resetMatrix();
  
  noFill();
  stroke(255);
  strokeWeight(1000);
  circle(width*.75, height*.75, 1512);
  stroke(c);
  strokeWeight(1);
  noFill();
  circle(width*.75, height*.75, width*.5);
  fill(255);
  noStroke();
  // matte
  rect(width*0, height*0, width, height*.25);
  rect(width*0, height*0, width*.25, height);
  rect(width*0, height*.75, width, height*.25);
  rect(width*.75, height*0, width*.25, height);
  
  noFill();
  stroke(c);
  rect(width*.25, height*.25, width*.5, height*.5);
  
  for(int i = 0; i < anchors.length; i++){
    flyer(anchors[i].x, anchors[i].y);
  }
  
  if(frameCount <= frameEnd){
    saveFrame("frames/####.png");
  }
}


void flyer(float x, float y){
  // noise is based on a circle centered on x,y
  float noiseScale = 1.0/64;
  PVector sampleOffset;
  float sampleRadius = width / 128;
  
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
    int drawRadius = 256;
    positions[i] = new PVector(adjust * drawRadius * 1, altAdjust * drawRadius);
  }
  
  stroke(c);
  strokeWeight(1);
  
  for(int i = 0; i < positions.length - 1; i++){
    resetMatrix();
    translate(x, y);
    translate(positions[i].x, positions[i].y);
    rotate(PVector.angleBetween(positions[i], positions[i+1]) * TAU);
    rotate(TAU * progress);
    arc(0, 0, i * 3, i * 3, TAU*.35, TAU*.65);
  }
}
