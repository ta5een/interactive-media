// Week 12 - Interactive Video Mirror
// Author: Mohammed Ta-Seen Islam

import controlP5.*;
import processing.video.*;

final color CELL_COLOR = color(164, 48, 227);
final color BACKGROUND_COLOR = color(227, 203, 48);

final int PAUSE_BUTTON_SIZE = 50;
final float PAUSE_BUTTON_PADDING = 25;

Capture video;
int cellSize = 15;
int columnCount;
int rowCount;

ControlP5 cp5;
boolean playStream = false;

void setup() {
  size(1050, 750);
  background(0);

  columnCount = width / cellSize;
  rowCount = height / cellSize;

  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);
  textMode(CENTER);

  video = new Capture(this, width, height);

  PVector bottomLeft = new PVector(0, height);
  PVector buttonPosition = bottomLeft.add(PAUSE_BUTTON_PADDING, -(PAUSE_BUTTON_PADDING + PAUSE_BUTTON_SIZE));
  cp5 = new ControlP5(this);
  cp5.addToggle("togglePlayStream")
    .setLabel("")
    .setValue(playStream)
    .setSize(PAUSE_BUTTON_SIZE, PAUSE_BUTTON_SIZE)
    .setPosition(buttonPosition.x, buttonPosition.y);
}

void draw() {
  if (playStream) {
    displayCapture();
  } else {
    displayNoCapture();
  }
}

void displayNoCapture() {
  push();
  background(0);
  textSize(30);
  textAlign(CENTER);
  text("Turn on the camera to view the effect", width / 2, height / 2);
  pop();
}

void displayCapture() {
  if (!video.available()) return;
  video.read();
  video.loadPixels();

  push();
  background(BACKGROUND_COLOR);

  for (int i = 0; i < columnCount; i++) {
    for (int j = 0; j < rowCount; j++) {
      int x = i * cellSize;
      int y = j * cellSize;
      int loc = (video.width - x - 1) + (y * video.width);

      color pixelColor = video.pixels[loc];
      float pixelSize = (brightness(pixelColor) / 255.0) * cellSize;

      noStroke();
      fill(CELL_COLOR);
      rect(x + cellSize/2, y + cellSize/2, pixelSize, pixelSize);
    }
  }

  pop();
}

void togglePlayStream(boolean shouldPlay) {
  playStream = shouldPlay;
  if (playStream) {
    video.start();
  } else {
    video.stop();
  }
}
