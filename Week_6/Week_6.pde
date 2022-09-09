// Week 6 (Develop a graphical user interface for an existing sketch)
// Author: Mohammed Ta-Seen Islam (13215660)

import controlP5.*;

static final boolean __DEBUG__ = true;
static final float MIN_TEMP = -10.0;
static final float MAX_TEMP = 40.0;
static final float MIN_SPEED = 0.0;
static final float MAX_SPEED = 10.0;

ControlP5 cp5;
ArrowGrid arrowGrid;
final int numCols = 8;
final int numRows = 6;

float currDir = 0.0;
float currGust = 2.0;
float currTemp = 8.0;

void setup() {
  size(1080, 607);
  background(255);
  cp5 = new ControlP5(this);
  arrowGrid = new ArrowGrid(numCols, numRows);

  int knobWidth = int(width * 0.08);
  int knobHeight = knobWidth;
  int sliderWidth = int(width * 0.25);
  int sliderHeight = int(height * 0.05);
  int guiSpacing = 30;
  int guiPadding = 20;

  var bottomRightWithPadding =
    new PVector(width - guiPadding, height - guiPadding);
  var gustSliderPos =
    bottomRightWithPadding.copy().sub(sliderWidth, sliderHeight);
  var tempSliderPos =
    gustSliderPos.copy().sub(0.0, sliderHeight + guiSpacing);
  var dirSliderPos =
    new PVector(gustSliderPos.x - guiPadding - knobWidth, height - guiPadding - knobHeight);

  cp5.addKnob("currDir")
    .setPosition(dirSliderPos.x, dirSliderPos.y)
    .setSize(knobWidth, knobHeight)
    .setRange(0.0, 360.0)
    .setNumberOfTickMarks(36)
    .snapToTickMarks(true);
  cp5.getController("currDir")
    .getCaptionLabel()
    .align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE)
    .setText("Direction")
    .setColor(color(0))
    .setPaddingX(0);

  cp5.addSlider("currTemp")
    .setPosition(tempSliderPos.x, tempSliderPos.y)
    .setSize(sliderWidth, sliderHeight)
    .setRange(MIN_TEMP, MAX_TEMP);
  cp5.getController("currTemp")
    .getCaptionLabel()
    .align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setText("Air Temperature (C)")
    .setColor(color(0))
    .setPaddingX(0);

  cp5.addSlider("currGust")
    .setPosition(gustSliderPos.x, gustSliderPos.y)
    .setSize(sliderWidth, sliderHeight)
    .setRange(MIN_SPEED, MAX_SPEED);
  cp5.getController("currGust")
    .getCaptionLabel()
    .align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setText("Gust (m/s)")
    .setColor(color(0))
    .setPaddingX(0);
}

void draw() {
  background(255);
  arrowGrid.draw(currDir, currGust, currTemp);
}
