// 20231004
// frames

// this one's a little more disorderly than usual, sorry.

color c = #930C27;

PGraphics [] frame = new PGraphics[7];

float progress;
int frameEnd = 512;

void setup() {
  size(1024, 1024);
  
  frameRate(50);
  noiseSeed(20231004);
  randomSeed(20231004);

  frame[0] = createGraphics(256 - 8, 512 - 16);
  frame[1] = createGraphics(128 - 8, 128 - 16);
  frame[2] = createGraphics(256 - 16, 64 - 16);
  frame[3] = createGraphics(64 - 11, 256 - 16);
  frame[4] = createGraphics(frame[3].width, frame[3].height);
  frame[5] = createGraphics(frame[3].width, frame[3].height);
  frame[6] = createGraphics(frame[3].width, frame[3].height);

  noSmooth();
  for (int i = 0; i < frame.length; i++) {
    frame[i].noSmooth();
  }
}

void draw() {
  background(255);
  
  progress = frameCount / float(frameEnd);

  for (int i = 0; i < frame.length; i++) {
    frame[i].beginDraw();
    frame[i].stroke(c);
    frame[i].fill(255);
    frame[i].rectMode(CENTER);
    frame[i].rect(frame[i].width/2, frame[i].height/2,
                  frame[i].width-1, frame[i].height-1);
    
  }

  // frame 0: big left-half frame
  frame[0].resetMatrix();
  PVector moon = new PVector(42, 42);
  int moonOffset = 11;
  frame[0].circle(moon.x, moon.y, 64);
  frame[0].circle(moon.x - moonOffset, moon.y - moonOffset, 63);
  // moon coverup real??
  frame[0].stroke(255);
  frame[0].rect(8, 6, 134, 16);
  frame[0].rect(0, 46, 28, 67);
  frame[0].stroke(c);
  frame[0].line(0, 0, frame[0].width, 0);
  frame[0].line(0, 0, 0, frame[0].height);
  
  int gridStep = 8;
  for(int y = 0; y < frame[0].height; y += gridStep){
    for(int x = 0; x < frame[0].width; x += gridStep){
      gnatMeander(x, y);
    }
  }
  
  frame[0].resetMatrix();
  frame[0].translate(0,frame[0].height - 64 - 8 );
  for(int i = 0; i < 64; i += 3){
    frame[0].line(8, i, frame[0].width - 8, i);
  }
  
  // frame 1: lower-right square canvas
  // removed
  
  // frame 2: horizontal strips
  for(int i = frameCount / 16 % 4; i < frame[2].width + frame[2].height; i += 4){
    frame[2].line(0, i, i, 0);
  }
  frame[2].translate(progress%1 * (frame[2].width+64) - 32,
                     frame[2].height / 2 + sin(progress*TAU * 8)*3);
  frame[2].rotate(progress*TAU*2);
  frame[2].noFill();
  frame[2].square(0, 0, frame[2].height - 18);
  //frame[2].circle(cos(-progress*TAU*2 + TAU*.25)*8, sin(-progress*TAU*2 + TAU*.25)*8, 8);
  
  // frame 3: vertical strips
  
  //frame[3].scale(-1, 0);
  float increment3 = map(cos(progress*TAU + TAU*.125*0 + TAU*.5), -1, 1, 3, 32);
  float increment4 = map(cos(progress*TAU + TAU*.125*1 + TAU*.5), -1, 1, 3, 32);
  float increment5 = map(cos(progress*TAU + TAU*.125*2 + TAU*.5), -1, 1, 3, 32);
  float increment6 = map(cos(progress*TAU + TAU*.125*3 + TAU*.5), -1, 1, 3, 32);
  for(float i = -frame[3].width; i < frame[3].height; i += increment3){
    frame[3].line(0, i, frame[3].width, i + frame[3].width);
  }
  for(float i = -frame[4].width; i < frame[4].height; i += increment4){
    frame[4].line(0, i, frame[4].width, i + frame[4].width);
  }
  for(float i = -frame[5].width; i < frame[5].height; i += increment5){
    frame[5].line(0, i, frame[5].width, i + frame[5].width);
  }
  for(float i = -frame[6].width; i < frame[6].height; i += increment6){
    frame[6].line(0, i, frame[6].width, i + frame[6].width);
  }
  
  frame[3].resetMatrix();
  frame[3].translate(frame[3].width/2, frame[3].height/2);
  frame[3].fill(255);
  frame[3].circle(0, sin(-progress*TAU + TAU*.125*0 + TAU*.5) * (frame[3].height/2 - 24), 16);
  frame[3].resetMatrix();
  
  frame[4].resetMatrix();
  frame[4].translate(frame[4].width/2, frame[4].height/2);
  frame[4].fill(255);
  frame[4].circle(0, sin(-progress*TAU - TAU*.125*1 + TAU*.5) * (frame[4].height/2 - 24), 16);
  frame[4].resetMatrix();
  
  frame[5].resetMatrix();
  frame[5].translate(frame[5].width/2, frame[5].height/2);
  frame[5].fill(255);
  frame[5].circle(0, sin(-progress*TAU - TAU*.125*2 + TAU*.5) * (frame[4].height/2 - 24), 16);
  frame[5].resetMatrix();
  
  frame[6].resetMatrix();
  frame[6].translate(frame[6].width/2, frame[6].height/2);
  frame[6].fill(255);
  frame[6].circle(0, sin(-progress*TAU - TAU*.125*3 + TAU*.5) * (frame[6].height/2 - 24), 16);
  frame[6].resetMatrix();


  // alright, show's over, wrap it up
  for (int i = 0; i < frame.length; i++) {
    frame[i].endDraw();
  }

  stroke(c);
  fill(c);
  rect(width*.25, height*.25, width*.5, height*.5);

  image(frame[0], 256 + 8, 256 + 8);
  //image(frame[1], 512 + 8, 512 + 32);

  // wave the vertical and horizonal strips
  PGraphics img = frame[3];
  for(int i = 0; i < 4; i++){
    image(frame[2], 512 + 8, 256 + 64*i - (8*(i-1)));
    
    switch(i){
      case 1:
        img = frame[4];
        break;
      case 2:
        img = frame[5];
        break;
      case 3:
        img = frame[6];
        break;
      default:
        img = frame[3];
        break;
    }
    image(img, 512 + 62 * i + 8, 256 + 128 + 8+ sin(progress*TAU + TAU*.125*i)*128);
  }
  image(frame[2], 512 + 8, 256 + 64*4 - (8*(4-1)));
  
  //image(frame[2], 512 + 8, 256 + 64);
  //image(frame[3], 512 + 64 * 1 + 6, 256 + 128 + 8+ sin(progress*TAU + TAU*0.125)*128);
  //image(frame[2], 512 + 8, 256 + 64*2 - 8);
  //image(frame[3], 512 + 64 * 2 + 2, 256 + 128 + 8+ sin(progress*TAU + TAU*0.25)*128);
  //image(frame[2], 512 + 8, 256 + 64*3 - 16);
  //image(frame[3], 512 + 64 * 3 - 2, 256 + 128 + 8+ sin(progress*TAU + TAU*0.375)*128);
  
  if(frameCount <= frameEnd){
    saveFrame("frames/####.png");
  }
  
}


void gnatMeander(float x, float y){
  // noise is based on a circle centered on x,y
  float noiseScale = 1.0/256;
  PVector sampleOffset = PVector.fromAngle(TAU * progress);
  float sampleRadius = width / 256;
  float drawRadius = 1000;
  sampleOffset.mult(sampleRadius);
  
  frame[0].resetMatrix();
  frame[0].translate(x, y);
  
  float adjust = noise((x + sampleOffset.x + 100) * noiseScale,
                       (y + sampleOffset.y + 100) * noiseScale) * 2 - 1;
  
  float altAdjust = noise((y + sampleOffset.y + 1024) * noiseScale,
                       (x + sampleOffset.x + 1024) * noiseScale) * 2 - 1;
  
  frame[0].stroke(c);
  frame[0].fill(c);
  
  // warp the grid a little and add a secondary motion
  frame[0].translate(adjust * drawRadius, altAdjust * drawRadius);
  
  //circle(0, -1, 0); // round the base a bit
  
  //float manualOffset = TAU/1.9; // looks best to me for this seed
  //rotate(adjust * TAU + manualOffset);
  
  //frame[0].strokeWeight(2);
  frame[0].point(216, -232);
  
  //strokeWeight(1);
  //line(0, 0, 0, drawRadius + 2); // sharpen the far edge a bit
  
}
