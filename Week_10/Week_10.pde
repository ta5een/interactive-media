// Week 10 - Process an Image
// Author: Mohammed Ta-Seen Islam

import controlP5.*;

PImage img;

int pxHeight = 1;
int pxWidth = 1;

int currResolution = 1;
int prevResolution = 1;

float currRedness = 1.0;
float prevRedness = currRedness;

ControlP5 cp5;

void setup() {
  img = loadImage("car.jpeg");
  surface.setSize(img.width, img.height);
  cp5 = new ControlP5(this);
  cp5.addSlider("currResolution").setValue(150).setRange(25, 250).setPosition(0, 10);
}

void draw() {
  if (currResolution != prevResolution || currRedness != prevRedness) {
    prevResolution = currResolution;
    prevRedness = currRedness;

    pxWidth = width / currResolution;
    pxHeight = height / currResolution;

    for (int y = 0; y < img.height; y += pxHeight) {
      for (int x = 0; x < img.width; x += pxWidth) {
        color pixelColor = img.get(x, y);

        // More efficient to calculate with right shift operator ">>"
        // https://processing.org/reference/red_.html
        int redValue = int((pixelColor >> 16 & 0xFF) * currRedness);
        int greenValue = pixelColor >> 8 & 0xFF;
        int blueValue = pixelColor & 0xFF;
        fill(redValue, greenValue, blueValue);

        noStroke();
        rect(x, y, pxWidth, pxHeight);
      }
    }

    fill(255);
    textSize(30);
    text(String.format("Redness: %d%%", int(currRedness * 100)), 0, 50);
  }
}

void mouseMoved() {
  currRedness = map(mouseY, height, 0, 0.0, 1.0);
}
