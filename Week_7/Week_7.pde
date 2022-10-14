import beads.*;
import java.util.Arrays;

AudioContext ac;
Glide freq;
WavePlayer wp;

void setup() {
  size(400, 400);

  ac = new AudioContext();

  freq = new Glide(ac, 200);
  freq.setGlideTime(2000);
  wp = new WavePlayer(ac, freq, Buffer.SINE);
  freq.setValue(1000);

  Gain g = new Gain(ac, 1, 0.1);
  g.addInput(wp);
  ac.out.addInput(g);
  ac.start();
}

/*
 * Here's the code to draw a scatterplot waveform.
 * The code draws the current buffer of audio across the
 * width of the window. To find out what a buffer of audio
 * is, read on.
 *
 * Start with some spunky colors.
 */
color fore = color(255, 102, 204);
color back = color(0,0,0);

void draw() {
// Set the frequency based on the mouse Y position.
  // freq.setValue(mouseY * 4);

  loadPixels();
  //set the background
  Arrays.fill(pixels, back);

  //scan across the pixels
  for(int i = 0; i < width; i++) {
    //for each pixel work out where in the current audio buffer we are
    int buffIndex = i * ac.getBufferSize() / width;
    //then work out the pixel height of the audio data at that point
    int vOffset = (int)((1 + ac.out.getValue(0, buffIndex)) * height / 2);
    //draw into Processing's convenient 1-D array of pixels
    vOffset = min(vOffset, height);
    pixels[vOffset * height + i] = fore;
  }
  updatePixels();
  text(freq.getValue(), 30, 30); // print the frequency
}
