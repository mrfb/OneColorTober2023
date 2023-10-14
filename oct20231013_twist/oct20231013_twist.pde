// twist
// little more cleaned up today, little less commented.

int seed = 20231013;
color col = #E34C00;

boolean saveImages = false;
int frameEnd = 512;

float progress;
PVector topLeft, topCenter, topRight,
  midLeft, midCenter, midRight,
  botLeft, botCenter, botRight;
PVector canvasTL, canvasTR, canvasBL, canvasBR;
PGraphics layerA, layerB, ditherMaskA, ditherMaskB;

void setup() {
  size(1024, 1024);

  frameRate(50);
  noiseSeed(seed);
  randomSeed(seed);
  noSmooth();

  rectMode(CENTER);
  strokeCap(PROJECT);

  topLeft = new PVector(width*0.25, height*0.25);
  topCenter = new PVector(width*0.50, height*0.25);
  topRight = new PVector(width*0.75, height*0.25);

  midLeft = new PVector(width*0.25, height*0.50);
  midCenter = new PVector(width*0.50, height*0.50);
  midRight = new PVector(width*0.75, height*0.50);

  botLeft = new PVector(width*0.25, height*0.75);
  botCenter = new PVector(width*0.50, height*0.75);
  botRight = new PVector(width*0.75, height*0.75);

  canvasTL = new PVector(0, 0);
  canvasTR = new PVector(width, 0);
  canvasBL = new PVector(0, height);
  canvasBR = new PVector(width, height);

  background(255);

  layerA = createGraphics(width, height);
  layerB = createGraphics(width, height);
  ditherMaskA = createGraphics(width, height);
  ditherMaskB = createGraphics(width, height);
  
  ditherMaskA.beginDraw();
  ditherMaskA.background(255);
  //ditherMaskA.clear();
  ditherMaskA.stroke(0);
  lineQuad(ditherMaskA, canvasTL, canvasTR, canvasBL, canvasBR, 511);
  lineQuad(ditherMaskA, canvasTL, canvasBL, canvasTR, canvasBR, 511);
  //ditherMaskA.filter(INVERT);
  ditherMaskA.endDraw();
  
  ditherMaskB.beginDraw();
  ditherMaskB.background(255);
  ditherMaskB.stroke(0);
  lineQuad(ditherMaskB, canvasTL, canvasTR, canvasBL, canvasBR, 512);
  lineQuad(ditherMaskB, canvasTL, canvasBL, canvasTR, canvasBR, 512);
  ditherMaskB.endDraw();
}

void draw() {
  progress = frameCount / float(frameEnd);
  background(255);
  
  layerA.beginDraw();
  layerA.background(255);
  layerA.stroke(col);
  layerA.strokeWeight(8);
  layerA.noFill();
  
  layerB.beginDraw();
  layerB.background(255);
  layerB.stroke(col);
  layerB.strokeWeight(8);
  layerB.noFill();
  
  float sineWave = sin(progress * TAU);
  float pull = map(sineWave, -1, 1, 0, 1);

  int radius = 512 - 32;
  float twistMax = TAU * 1.75;
  float arcLength = TAU / 4.0;
  for (int i = 16; i < radius; i += 32) {
    layerA.arc(midCenter.x, midCenter.y, i, i, pull*twistMax * (i / float(radius)), pull*twistMax + arcLength);
    layerB.arc(midCenter.x, midCenter.y, i, i, pull*twistMax * (i / float(radius))+TAU*.50, pull*twistMax + arcLength+TAU*.50);
  }

  layerA.endDraw();
  layerB.endDraw();

  resetMatrix();

  layerA.mask(ditherMaskA);
  image(layerA, 0, 0);
  layerB.mask(ditherMaskB);
  image(layerB, 0, 0);

  stroke(col);
  noFill();
  square(midCenter.x, midCenter.y, width/2);

  if (frameCount <= frameEnd && saveImages) {
    saveFrame("frames/####.png");
    if (frameCount == frameEnd) println("done!");
  }
}

// draw lines A and B, and also the n lines interpolated between them
void lineQuad(PGraphics g, PVector startA, PVector endA, PVector startB, PVector endB, int n) {
  for (int i = 0; i <= n; i++) {
    g.line(PVector.lerp(startA, startB, i / float(n)).x,
           PVector.lerp(startA, startB, i / float(n)).y,
           PVector.lerp(endA, endB, i / float(n)).x,
           PVector.lerp(endA, endB, i / float(n)).y);
  }
}
