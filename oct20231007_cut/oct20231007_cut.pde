int date = 20231007;
// 20231007: cut

color c = #FA90A3;

float progress;
int frameEnd = 512;

PGraphics topLeft, topRight, botLeft, botRight;
PVector[] points;

void setup() {
  size(1024, 1024);
  
  topLeft = createGraphics(256, 256);
  topRight = createGraphics(256, 256);
  botLeft = createGraphics(256, 256);
  botRight = createGraphics(256, 256);
  
  frameRate(50);
  noiseSeed(date);
  randomSeed(date);
  println(date);
  noSmooth();
  
  points = new PVector[1500];
  // r/theta pairs
  for(int i = 0; i < points.length; i++){
    points[i] = new PVector(map(abs(cos(random(TAU))), 0, 1, 64, 256), random(TAU));
  }
  
  background(255);
  rectMode(CENTER);
}

void draw() {
  background(255);
  stroke(c);
  
  progress = frameCount / float(frameEnd);
  
  // TOP LEFT CANVAS
  topLeft.beginDraw();
  topLeft.background(255);
  topLeft.translate(256, 256);
  //topLeft.rotate(progress*TAU);
  topLeft.fill(c);
  topLeft.stroke(c);
  for(float theta = TAU*.50; theta <= TAU; theta += TAU * .001){
    topLeft.line(cos(theta+progress*TAU)*256, sin(theta+progress*TAU)*257,
                 -cos(theta+progress*TAU)*256, -sin(theta+progress*TAU)*257);
  }
  
  // mask over
  topLeft.resetMatrix();
  topLeft.stroke(255);
  // moire
  for(int i = 0; i < 256; i += 4){
    //topLeft.line(0, i+0, 256, i+0);
    topLeft.line(0, i+1, 256, i+1);
    topLeft.line(0, i+2, 256, i+2);
    topLeft.line(0, i+3, 256, i+3);
  }
  topLeft.endDraw();
  
  // TOP RIGHT CANVAS
  topRight.beginDraw();
  topRight.background(255);
  topRight.rectMode(CENTER);
  topRight.stroke(c);
  topRight.noFill();
  topRight.stroke(c);
  topRight.translate(0, 256);
  // spinning squares
  for(float theta = 0; theta <= TAU; theta += TAU * .02){
    topRight.square(-sin(theta+progress*TAU*2)*(256-9), -cos(theta+progress*TAU*2)*(256-8), 16);
    topRight.pushMatrix();
    topRight.rotate(theta);
    topRight.square(-cos(theta+progress*TAU)*(128), -sin(theta+progress*TAU)*(128), 8);
    topRight.square(-cos(theta+progress*TAU + TAU*.02)*(128), -sin(theta+progress*TAU + TAU*.02)*(128), 8);
    topRight.line(-cos(theta+progress*TAU)*(128), -sin(theta+progress*TAU)*(128),
                  -cos(theta+progress*TAU + TAU*.02)*(128), -sin(theta+progress*TAU + TAU*.02)*(128));
    topRight.popMatrix();
  }
  topRight.rotate(progress*TAU*0.25);
  topRight.square(0, 0, 64);
  topRight.endDraw();
  
  // BOTTOM LEFT CANVAS
  botLeft.beginDraw();
  botLeft.background(255);
  botLeft.stroke(c);
  botLeft.strokeWeight(2);
  botLeft.translate(256, 0);
  // polar coordinate spin
  botLeft.rotate(TAU*progress);
  for(int i = 1; i < points.length; i ++){
    botLeft.point(cos(points[i].y)*points[i].x, sin(points[i].y)*points[i].x);
  }
  botLeft.endDraw();
  
  // BOTTOM RIGHT CANVAS
  botRight.beginDraw();
  botRight.background(255);
  botRight.stroke(c);
  botRight.noFill();
  // radial circles
  for(int r = 0; r <= 512; r += 8){
    botRight.circle(0, 0, r);
  }
  for(float theta = 0; theta <= TAU*.26; theta += TAU *.005){
    float rStart = 64+32 + sin(TAU*progress+theta)*32;
    float rEnd = 256 - 64 + cos(TAU*progress+theta)*48;
    botRight.line(cos(theta)*rStart, sin(theta)*rStart,
                  cos(theta)*rEnd, sin(theta)*rEnd);
  }
  botRight.endDraw();
  
  image(topLeft, 256, 256);
  image(topRight, 512, 256);
  image(botLeft, 256, 512);
  image(botRight, 512, 512);
  
  noFill();
  // brackets
  line(256, 256, 256, 512-128); // top left
  line(256, 256, 512-128, 256);
  line(768, 256, 768, 512 - 128); // top right
  line(768, 256, 768 - 128, 256);
  line(256, 768, 512 - 128, 768); // bottom left
  line(256, 768, 256, 512+128); 
  //square(width*.25, height*.25, width*.50);
  
  //arc(64, 64, 32, 32, 0, progress*TAU);
  
  if(frameCount <= frameEnd){
    saveFrame("frames/####.png");
    if(frameCount == frameEnd) println("done!");
  }
}
