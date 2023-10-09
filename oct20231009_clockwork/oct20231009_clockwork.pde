// 20231009
// swap

color col = #B2F4FF;

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
}

void draw() {
  background(255);
  stroke(col);

  progress = frameCount / float(frameEnd);
  //float shift = map(sin(progress*TAU), -1, 1, -0.01, 1.01);
  //shift = constrain(shift, 0, 1); // hold at extremes

  noFill();
  //square(width/2, height/2, width*.50);

  strokeWeight(1);
  translate(width/2, height/2);
  for(int i = 0; i < 360; i += 5){
    pushMatrix();
    float radius = - sqrt(30*30+30*30)/2;
    float sineWave = sin(progress*TAU + radians(i));
    float shift = map(sineWave, -1, 1, 7, 2048);
    float offset = constrain(shift, 0, 256);
    translate(radius + offset, 0);
    line(256 + offset, 0, 64 + offset*2, 0);
    rotate(TAU/8.0);
    square(0, 0, 30);
    
    
    popMatrix();
    
    rotate(radians(5));
  }
  
  strokeWeight(2);
  rotate(-progress * TAU); // overall spin
  //translate(0, 0);
  
  pushMatrix();
  rotate(TAU * 0.146);
  translate(-288, 0);
  rotate(progress*TAU*-16);
  square(0, 0, 64); // big square pushes in
  popMatrix();
  
  pushMatrix();
  rotate(TAU * 0.000);
  translate(0, 63);
  rotate(-progress*TAU*-32);
  square(0, 0, 48); // little square pushes back out
  popMatrix();
  
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
