// 20231010
// swap

color col = #FA055B;

float progress;
int frameEnd = 512;

PVector topLeft, topCenter, topRight,
        midLeft, midCenter, midRight,
        botLeft, botCenter, botRight;
PVector shifter, shifter2;

PGraphics strings, stringsMask;

void setup() {
  size(1024, 1024);

  frameRate(50);
  noiseSeed(20231010);
  randomSeed(20231010);
  noSmooth();
  
  rectMode(CENTER);

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
  
  strings = createGraphics(width, height);
  stringsMask = createGraphics(width, height);
  
  stringsMask.beginDraw();
  stringsMask.background(255);
  PVector canvasTL, canvasTR, canvasBL, canvasBR;
  canvasTL = new PVector(0, 0);
  canvasTR = new PVector(stringsMask.width, 0);
  canvasBL = new PVector(0, stringsMask.height);
  canvasBR = new PVector(stringsMask.width, stringsMask.height);
  
  stringsMask.stroke(0);
  int n = stringsMask.height/2;
  for (int i = 0; i <= n; i++) {
    stringsMask.line(PVector.lerp(canvasTL, canvasBL, i / float(n)).x,
         PVector.lerp(canvasTL, canvasBL, i / float(n)).y,
         PVector.lerp(canvasTR, canvasBR, i / float(n)).x,
         PVector.lerp(canvasTR, canvasBR, i / float(n)).y);
  }
  stringsMask.endDraw();
  
  
}

void draw() {
  progress = frameCount / float(frameEnd);
  
  background(255);
  stroke(col);
  strokeWeight(1);
  noFill();
  
  //lineQuad(topLeft, topRight, botLeft, botRight, 16);
  //lineQuad(topLeft, botLeft, botRight, topRight, 16);
  
  
  PVector sA, sB, sC, sD;
  sA = midCenter.copy().add(-32, -32);
  sB = midCenter.copy().add(32, -32);
  sC = midCenter.copy().add(-32, 32);
  sD = midCenter.copy().add(32, 32);
  lineQuad(sA, sB, sC, sD, 4);
  lineQuad(sA, sC, sB, sD, 4);
  
  translate(midCenter.x, midCenter.y);
  square(0, 0, width*.50);
  
  strings.beginDraw();
  strings.background(255);
  strings.stroke(col);
  
  for(int i = 0; i < 360; i += 18){
    pushMatrix();
    //rotate(radians(i));
    float sineWave = sin(progress*TAU + radians(i));
    float shift = map(sineWave, -1, 1, 0, 2);
    shift = constrain(shift, 0, 1);
    
    int radius = 256-32;
    int offset = 225;
    
    PVector A = new PVector(cos(radians(i)), sin(radians(i)));
    PVector B = new PVector(cos(radians(i + offset)), sin(radians(i + offset)));
    A.mult(radius);
    B.mult(radius);
    PVector AB = PVector.lerp(A, B, shift);
    
    translate(AB.x, AB.y);
    
    strings.line(AB.x + 512, -9999, AB.x + 512, AB.y + 512);
    
    rotate(TAU * 1.625 * shift);
    square(0, 0, 32);
    
    if(shift < 1){
      fill(col);
      square(0, 0, (1-shift) * 32);
      noFill();
    }
    
    popMatrix();
  }
  
  strings.endDraw();
  resetMatrix();
  
  // this isn't quite working how i want, but...
  strings.mask(stringsMask);
  image(strings, 0, 0);
  
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
