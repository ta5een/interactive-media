static final boolean __DEBUG__ = true;

// An instance of a ball
BouncingBall ball;
// The diameter of the ball
float ballDiameter = 48.0;

// Downward force of 0.2 units
PVector gravity = new PVector(0.0, 0.2);
// Velocity of bouncing ball
// PVector velocity = new PVector(1.5, 2.1);
PVector velocity = new PVector(2.0, 0.1);

void setup() {
  // if (__DEBUG__) frameRate(10);
  size(640, 480);
  var startPosition = new PVector(width * 0.5, height * 0.2);
  ball = new BouncingBall(ballDiameter, startPosition, velocity, gravity);
}

void draw() {
  background(0);
  ball.draw();
}
