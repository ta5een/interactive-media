import controlP5.*;

static final boolean __DEBUG__ = true;
static final float DEFAULT_BALL_DIAMETER = 45.0;
static final float DEFAULT_BALL_FILL_LERP = 0.8;

ControlP5 cp5;

BouncingBall ball;
final color ballWarmColor = color(250, 90, 50);
final color ballCoolColor = color(50, 200, 250);
float ballDiameter = DEFAULT_BALL_DIAMETER;
float ballFillLerp = DEFAULT_BALL_FILL_LERP;

// Downward force of 0.2 units
PVector gravity = new PVector(0.0, 0.2);
// Velocity of bouncing ball
PVector velocity = new PVector(1.5, 2.1);

void setup() {
  size(640, 480);
  cp5 = new ControlP5(this);

  var position = new PVector(width * 0.5, height * 0.2);
  ball = new BouncingBall(ballDiameter, position, velocity, gravity);

  var sliderWidth = int(width * 0.4);
  var sliderHeight = 20;
  var sliderPosition = new PVector((width - 20.0) - sliderWidth, (height - 20.0) - sliderHeight);

  cp5.addSlider("ballDiameterSlider")
    .setPosition(sliderPosition.x, sliderPosition.y - sliderHeight)
    .setSize(sliderWidth, sliderHeight)
    .setRange(5.0, 50.0)
    .setNumberOfTickMarks(10)
    .setValue(ballDiameter);

  cp5.addSlider("ballFillSlider")
    .setPosition(sliderPosition.x, sliderPosition.y)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0.0, 1.0)
    .setValue(ballFillLerp);

  cp5.getController("ballDiameterSlider")
    .getCaptionLabel()
    .align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE)
    .setPaddingX(0);

  cp5.getController("ballFillSlider")
    .getCaptionLabel()
    .align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE)
    .setPaddingX(0);
}

void draw() {
  background(0);
  ball.draw();
}

void ballDiameterSlider(float newDiameter) {
  // println("Ball Diameter = %f", newDiameter);
  ball.setDiameter(newDiameter);
}

void ballFillSlider(float lerpValue) {
  // println("Ball Fill Lerp = %f", lerpValue);
  ball.setFill(lerpColor(ballWarmColor, ballCoolColor, lerpValue));
}
