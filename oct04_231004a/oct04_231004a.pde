// 20231004
// frames

color c = #930C27;

PGraphics [] frame = new PGraphics[4];

float progress;
int frameEnd = 512;

void setup(){
  size(1024, 1024);
  
  frame[0] = createGraphics(256 - 8, 512 - 16);
  frame[1] = createGraphics(128 - 8, 128 - 16);
  frame[2] = createGraphics(256 - 16, 64 - 16);
  frame[3] = createGraphics(64 - 12, 256 - 16);
  
  noSmooth();
  for(int i = 0; i < frame.length; i++){
    frame[i].noSmooth();
  }
}

void draw(){
  background(255);
  
  for(int i = 0; i < frame.length; i++){
    frame[i].beginDraw();
    frame[i].stroke(c);
    frame[i].fill(255);
    frame[i].rect(0, 0, frame[i].width-1, frame[i].height-1);
    frame[i].noFill();
  }
  
  
  
  
  for(int i = 0; i < frame.length; i++){
    frame[i].endDraw();
  }
  
  stroke(c);
  rect(width*.25, height*.25, width*.5, height*.5);
  
  image(frame[0], 256 + 8, 256 + 8);
  image(frame[1], 512 + 8, 512+128 + 8);
  
  image(frame[2], 512 + 8, 256 + 8);
  image(frame[2], 512 + 8, 256 + 64);
  image(frame[2], 512 + 8, 256 + 64*2 - 8);
  image(frame[2], 512 + 8, 256 + 64*3 - 16);
  
  image(frame[3], 512 + 64 * 0 + 16, 256 + 64 * 1 + 24);
  image(frame[3], 512 + 64 * 1 + 12, 256 + 64 * 2 + 16);
  image(frame[3], 512 + 64 * 2 + 8, 256 + 64 * 3 + 12);
  image(frame[3], 512 + 64 * 3 + 4, 256 + 64 * 4 + 8);
}
