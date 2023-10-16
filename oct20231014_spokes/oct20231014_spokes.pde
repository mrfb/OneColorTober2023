//spokes
//20231014

// length of a full cycle of animation
// 512 gets us over the 10mb line on the gif
int frameEnd = 256;
boolean saveImages = true;

void setup() {
  size(1000, 1000);
  rectMode(CENTER);
  noSmooth();
  stroke(#BC9102);
  noFill();
}

void draw() {
  background(255);
  
  float progress = frameCount / float(frameEnd);
  // we use map and constrain to get the "hold" effects at the limits
  float sineWave = sin(progress * TAU);
  float pulse = map(sineWave, -1, 1, -1.56, 1.08);
  // 1.542 is just a magic number where the lines meet
  pulse = constrain(pulse, -1.542, 1);
  
  translate(width/2, height/2);
  
  // two circles -> two lines
  circle(0, 0, width*.25 * pulse * 2);
  circle(0, 0, width*.25);
  
  // three more lines
  arc(cos(TAU * 1/6.0 + progress * TAU)*width*.125, sin(TAU * 1/6.0 + progress * TAU)*width*.125,
      width*.25, height*.25, TAU * -3 / 6.0, TAU * -1 / 6.0);
  arc(cos(TAU * 3/6.0 + progress * TAU)*width*.125, sin(TAU * 3/6.0 + progress * TAU)*width*.125,
      width*.25, height*.25, TAU * -1 / 6.0, TAU * 1 / 6.0);
  arc(cos(TAU * 5/6.0 + progress * TAU)*width*.125, sin(TAU * 5/6.0 + progress * TAU)*width*.125,
      width*.25, height*.25, TAU * -5 / 6.0, TAU * -3 / 6.0);
  
  rotate(progress * TAU);
  
  // now, 100 (50*2) more lines bring us to 105 total
  for(float i = 0; i < 50; i += 1){
    rotate(TAU / 50);
    line(width*.125 * pulse, 0, width*.25 * pulse, 160);
    line(width*.125 * pulse, 0, -width*.25 * pulse, 200);
  }
  
  if (frameCount <= frameEnd && saveImages) {
    saveFrame("frames/####.png");
    if (frameCount == frameEnd) println("done!");
  }
  
}
