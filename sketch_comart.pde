/*
  author: yamada yuki
 */

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
FFT fft;
AudioPlayer player;
int buffersize = 512;

void setup() {
  size(800, 400);
  minim = new Minim(this);
  player = minim.loadFile("groove.mp3", buffersize);
  player.loop();
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw() {
  background(0);
  fft.forward( player.mix );

  for ( int i =0; i < fft.specSize(); i++) {
    float x = map(i, 0, fft.specSize(), 0, width);
    float y = map(fft.getBand(i), 0, 5.0, height, 0);

    float h = map(i, 0, fft.specSize(), 0, 180);
    stroke(h, 100, 100);
   // line(x, height, x, y);
    float ellipseSize = map(fft.getBand(i), 0, buffersize/16, 0, width);
    fill(h, 100, 100, 7);
    ellipse(x,height/2,ellipseSize,ellipseSize);
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
