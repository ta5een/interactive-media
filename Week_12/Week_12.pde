// Week 12 - Interactive Video Mirror
// Author: Mohammed Ta-Seen Islam

import processing.video.*;

final color CELL_COLOR = color(164, 48, 227);
final color BACKGROUND_COLOR = color(227, 203, 48);

Capture video;
int cellSize = 15;
int columnCount;
int rowCount;

void setup() {
  size(1050, 750);
  background(0);

  columnCount = width / cellSize;
  rowCount = height / cellSize;

  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);

  video = new Capture(this, width, height);
  video.start();
}

void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
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
  }
}
