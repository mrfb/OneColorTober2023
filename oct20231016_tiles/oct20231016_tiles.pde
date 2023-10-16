// 20231016 tiles
// shifts and moves
// easing

int seed = 20231016;
color col = #BF7568;

boolean saveImages = false;
int frameEnd = 512;

float progress;
PVector topLeft, topCenter, topRight,
  midLeft, midCenter, midRight,
  botLeft, botCenter, botRight;
PVector canvasTL, canvasTR, canvasBL, canvasBR;
PGraphics ditherMask;

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

  ditherMask = createGraphics(width, height);
  
  ditherMask.beginDraw();
  ditherMask.background(255);
  ditherMask.clear();
  ditherMask.stroke(255);
  ditherMask.strokeWeight(1);
  lineQuad(ditherMask, canvasTL, canvasTR, canvasBL, canvasBR, 512);
  lineQuad(ditherMask, canvasTL, canvasBL, canvasTR, canvasBR, 512);
  //ditherMaskA.filter(INVERT);
  ditherMask.endDraw();
}

void draw() {
  progress = frameCount / float(frameEnd);
  background(255);
  
  
  fill(col);
  int circleSize = 128;
  
  circle(topLeft.x,   topLeft.y,   circleSize);
  circle(topCenter.x, topCenter.y, circleSize);
  circle(topRight.x,  topRight.y,  circleSize);
  circle(midLeft.x,   midLeft.y,   circleSize);
  circle(midCenter.x, midCenter.y, circleSize);
  circle(midRight.x,  midRight.y,  circleSize);
  circle(botLeft.x,   botLeft.y,   circleSize);
  circle(botCenter.x, botCenter.y, circleSize);
  circle(botRight.x,  botRight.y,  circleSize);
  
  stroke(col);
  strokeWeight(8);
  noFill();
  
  float sineWave = sin(progress * TAU);
  float pull = map(sineWave, -1, 1, 0, 1);

  

  resetMatrix();

  stroke(col);
  noFill();
  square(midCenter.x, midCenter.y, width/2);

  image(ditherMask, 0, 0);

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
