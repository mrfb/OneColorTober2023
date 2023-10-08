// OneColorTober 20231003
// untitled moire composition

int frames = 1024;
float progress = 0;
color c = #4D3DE0;

void setup(){
  noiseSeed(20231003);
  randomSeed(20231003);
  size(1024, 1024);
  noSmooth();
  background(255);
  rectMode(CENTER);
  frameRate(50);
}

void draw(){
  background(255);
  stroke(c);
  
  // recalculate each frame for accuracy
  progress = float(frameCount)/float(frames);
  
  translate(width/2, height * 0.50);
  //rotate(progress);
  
  float pulseAmount = 128;
  float noiseRadius = 24;
  float noiseScale = .005;
  
  // central arc pulsator
  noFill();
  for(int i = 0; i < width; i += 3){
    float radius = i + noise(cos(progress*TAU) * noiseRadius, sin(progress*TAU) * noiseRadius, i * noiseScale)*pulseAmount;
    float arcStart = 0;
    float arcEnd = float(i)/float(width) + TAU/i*2;
    //rotate(TAU/1078);
    arc(0, 0, radius, radius, arcStart, arcEnd);
    rotate(TAU * 0.5);
    arcEnd *= 2;
    arc(0, 0, radius, radius, -arcStart, -arcEnd);
    
  }
  
  // top-right circle swisher
  pushMatrix();
  rotate(sin(progress*TAU)*TAU/8 - TAU/8);
  circle(width*(.125+.06125), 0, 32);
  popMatrix();
  
  // bottom-right square spinners
  pushMatrix();
  translate(width*.06125, height*.06125);
  rotate(progress*TAU);
  square(0, 0, 16);
  rotate(TAU/8);
  rotate(progress*TAU);
  square(0, 0, 32);
  rotate(TAU/8);
  rotate(progress*TAU);
  square(0, 0, 60);
  popMatrix();
  
  resetMatrix();
  translate(width/2, height * 0.50);
  
  // circle mask for pulsator
  strokeWeight(500);
  stroke(#ffffff);
  circle(0, 0, width*.5 + 500);
  stroke(c);
  strokeWeight(1);
  circle(0, 0, width*.5);
  
  // some basic structure
  line(0, width*.25, 0, -width*.25);
  line(width*.25, 0, -width*.25, 0);
  line(-width*.25, -height*.25, width*.25, height*.25);
  line(0, 0, -width * .25, height*.25);
  line(0, width*-.25, -height*.25, 0);
  rect(0, 0, width * .5, height * .5);
  rect(0, 0, width * .25, height * .25);
  
  // some lattices
  for(float i = 0; i < width * .25; i += 3){
    line(i, 0, i, -i);
    line(i, -i, 0, i);
    line(width*.25, 0, i, -height*.25);
  }
  
  // circular lattice
  for(float i = sin(progress*TAU) + 3; i < width * .25; i += 3){
    line(-i, 0, -cos(i * TAU/1024)*width*.25, sin(i * TAU/1024)*width*.25);
  }
  
  // top-left line triangles
  for(float i = height * .125; i < height * .25; i += 3){
    line(0, -i, -height*.25 + i, -i);
    line(-i, -height*.25 + i, -i, 0);
  }
  
  // a circle and lines in the circle
  fill(#ffffff);
  translate(-width/16, height * -3.0/16);
  circle(0, 0, width/16.0);
  //rotate(-TAU/8);
  for(float i = -width/32; i < width/32; i += 3){
    line(i, -i, i, 0);
  }
  
  // swishy tails by the circle
  translate(-width/8 + width/16 - 3, 0);
  for(float i = -width/32; i < width/32-32; i += 3){
    line(-i, -sin(progress*TAU+i)*16 - i, -i,  -sin(progress*TAU+i)*16);
  }
  
  // save frames for the gif
  if(frameCount <= frames){
    saveFrame("frames/####.png");
    if(frameCount == frames){
      println("done!");
    }
  }
}
