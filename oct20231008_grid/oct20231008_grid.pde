// 20231008
// grid

color col = #D4D80B;

float progress;
int frameEnd = 512;

PVector topLeft, topCenter, topRight,
        midLeft, midCenter, midRight,
        botLeft, botCenter, botRight;
PVector shifter, shifter2;

void setup() {
  size(1024, 1024);

  frameRate(50);
  noiseSeed(20231006);
  randomSeed(20231006);
  noSmooth();

  shifter = new PVector();
  shifter2 = new PVector();
  
  topLeft = new PVector(width*0.25, height*0.25);
  topCenter = new PVector(width*0.50, height*0.25);
  topRight = new PVector(width*0.75, height*0.25);
  
  midLeft = new PVector(width*0.25, height*0.50);
  midCenter = new PVector(width*0.50, height*0.50);
  midRight = new PVector(width*0.75, height*0.50);
  
  botLeft = new PVector(width*0.25, height*0.75);
  botCenter = new PVector(width*0.50, height*0.75);
  botRight = new PVector(width*0.75, height*0.75);

  background(255);
}

void draw() {
  background(255);
  stroke(col);

  progress = frameCount / float(frameEnd);
  float shift = map(sin(progress*TAU), -1, 1, -0.01, 1.01);
  shift = constrain(shift, 0, 1); // hold at extremes

  noFill();
  square(width*.25, height*.25, width*.50);

  // hourglass triangles
  lineQuad(topLeft, topCenter, botCenter, botLeft, 64);
  lineQuad(topRight, topCenter, botCenter, botRight, 64);

  // bottom left quad
  shifter = PVector.lerp(botLeft, midCenter, shift);
  lineQuad(midCenter, shifter, botCenter, botLeft, 32);
  shifter = PVector.lerp(botLeft, midCenter, 1 - shift);
  lineQuad(midCenter, midLeft, shifter, botLeft, 32);

  // bottom right quad
  shifter = PVector.lerp(midRight, botRight, shift);
  lineQuad(midCenter, midRight, botCenter, shifter, 32);
  lineQuad(botCenter, botRight, botCenter, shifter, 32);
  lineQuad(shifter, botRight, botCenter, shifter, 32);
  
  // top left quad
  shifter = PVector.lerp(midLeft, midCenter, 1-shift);
  lineQuad(midCenter, topCenter, shifter, topLeft, 32);
  shifter = PVector.lerp(midLeft, midCenter, 1-shift);
  lineQuad(midCenter, midLeft, shifter, shifter, 32);
  lineQuad(topLeft, shifter, midLeft, shifter, 32);
  
  // top right quad
  shifter = PVector.lerp(topRight, midCenter, 1-shift);
  lineQuad(midCenter, topCenter, shifter, topRight, 32); // top half
  shifter = PVector.lerp(midCenter, midRight, 1-shift);
  shifter2 = PVector.lerp(midRight, midCenter, shift);
  lineQuad(midCenter, shifter, topRight, midRight, 32); // bottom half
  
  if (frameCount <= frameEnd) {
    saveFrame("frames/####.png");
    if(frameCount == frameEnd) println("done!");
  }
}

// draw lines A and B, and also the n lines interpolated between them
void lineQuad(PVector startA, PVector endA, PVector startB, PVector endB, int n) {
  for (int i = 0; i <= n; i++) {
    line(PVector.lerp(startA, startB, i / float(n)).x,
      PVector.lerp(startA, startB, i / float(n)).y,
      PVector.lerp(endA, endB, i / float(n)).x,
      PVector.lerp(endA, endB, i / float(n)).y);
  }
}
