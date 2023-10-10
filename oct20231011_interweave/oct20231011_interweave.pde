// 20231011
// interweave

color col = #FAC505;

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
  int n = stringsMask.height/5;
  for (int i = 0; i <= n; i++) {
    stringsMask.line(PVector.lerp(canvasTL, canvasBL, i / float(n)).x,
         PVector.lerp(canvasTL, canvasBL, i / float(n)).y,
         PVector.lerp(canvasTR, canvasBR, i / float(n)).x,
         PVector.lerp(canvasTR, canvasBR, i / float(n)).y);
    stringsMask.line(PVector.lerp(canvasTL, canvasTR, i / float(n)).x,
         PVector.lerp(canvasTL, canvasTR, i / float(n)).y,
         PVector.lerp(canvasBL, canvasBR, i / float(n)).x,
         PVector.lerp(canvasBL, canvasBR, i / float(n)).y);
  }
  stringsMask.endDraw();
  
  
}

void draw() {
  progress = frameCount / float(frameEnd);
  
  background(255);
  stroke(col);
  strokeWeight(5);
  noFill();
  
  //lineQuad(topLeft, topRight, botLeft, botRight, 16);
  //lineQuad(topLeft, botLeft, botRight, topRight, 16);
  
  
  PVector sA, sB, sC, sD;
  int gridRadius = 128;
  sA = new PVector(-gridRadius, -gridRadius);
  sB = new PVector(gridRadius, -gridRadius);
  sC = new PVector(-gridRadius, gridRadius);
  sD = new PVector(gridRadius, gridRadius);
  
  translate(midCenter.x, midCenter.y);
  
  float sineWave = sin(progress*TAU);
  float shift = map(sineWave, -1, 1, -1, 2);
  shift = constrain(shift, 0, 1);
  
  pushMatrix();
  rotate(shift * TAU * .125);
  lineQuad(sA, sB, sC, sD, 4);
  popMatrix();
  pushMatrix();
  rotate(-shift * TAU * .375);
  lineQuad(sA, sC, sB, sD, 4);
  popMatrix();
  
  
  //square(0, 0, width*.50);
  
  strings.beginDraw();
  strings.background(255);
  strings.stroke(col);
  
  
  
  for(int i = 0; i < 360; i += 45){
    pushMatrix();
   
    int radius = 256 - 32;
    int offset = 90;
    
    PVector A = new PVector(cos(radians(i)), sin(radians(i)));
    PVector B = new PVector(cos(radians(i + offset)), sin(radians(i + offset)));
    A.mult(radius);
    B.mult(radius);
    PVector AB = PVector.lerp(A, B, shift);
    
    translate(AB.x, AB.y);
    
    rotate(TAU * 0.875 * shift);
    square(0, 0, 32);
    
    if(shift < 1){
      fill(col);
      square(0, 0, (1-shift) * 32);
      noFill();
    }
    
    line(-9999, 0, 9999, 0);
    line(0, -9999, 0, 9999);
    
    popMatrix();
  }
  
  sineWave = sin(progress*TAU + TAU*0.25);
  shift = map(sineWave, -1, 1, -1, 2);
  shift = constrain(shift, 0, 1);
  
  for(float i = 22.5; i < 360 + 22.5; i += 45){
    pushMatrix();
    //rotate(radians(i));
    
    int radius = 256 - 31;
    int offset = 90;
    
    PVector A = new PVector(cos(radians(i)), sin(radians(i)));
    PVector B = new PVector(cos(radians(i + offset)), sin(radians(i + offset)));
    A.mult(radius);
    B.mult(radius);
    PVector AB = PVector.lerp(A, B, shift);
    
    translate(AB.x, AB.y);
    
    rotate(-TAU * 0.875 * shift + TAU*.25);
    square(0, 0, 32);
    
    if(shift < 1){
      fill(col);
      square(0, 0, (1-shift) * 32);
      noFill();
    }
    
    line(-9999, 0, 9999, 0);
    line(0, -9999, 0, 9999);
    
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
