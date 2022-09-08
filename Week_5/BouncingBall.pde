/**
 * Bouncing Ball with Vectors
 * by Daniel Shiffman,
 * adapted by Mohammed Ta-Seen Islam.
 *
 * Demonstration of using vectors to control motion of body
 * This example is not object-oriented
 * See AccelerationWithVectors for an example of how to simulate motion using vectors in an object
 */

class BouncingBall {
  // The width and height of the shape
  private float _diameter;
  // Location of shape
  private PVector _position;
  // Velocity of shape
  private PVector _velocity;
  // Gravity acts at the shape's acceleration
  private final PVector _gravity;

  private boolean isOnFloor = false;

  public BouncingBall(
    float diameter,
    PVector position,
    PVector velocity,
    PVector gravity
  ) {
    _diameter = diameter;
    _position = position;
    _velocity = velocity;
    _gravity = gravity;
  }

  public void draw() {
    var radius = _diameter / 2.0;
    var ballMinBounds = _position.copy().sub(radius, radius);
    var ballMaxBounds = _position.copy().add(radius, radius);

    // Bounce off left and right edges of the window
    if ((ballMaxBounds.x >= width) || (ballMinBounds.x <= 0)) {
      _velocity.x *= -1.0;
    }

    // Bounce off the bottom edge of the window
    if (ballMaxBounds.y >= height) {
      isOnFloor = true;
      // Reduce the velocity ever so slightly when it hits the bottom edge
      _velocity.y *= -0.95;
      _position.y = height - radius;
    } else {
      isOnFloor = false;
    }

    _position.add(_velocity);
    _velocity.add(_gravity);

    // Display circle at position vector
    push();
    stroke(255);
    strokeWeight(2);
    fill(127);
    ellipse(_position.x, _position.y, _diameter, _diameter);
    if (__DEBUG__) {
      stroke(255, 0, 0);
      ellipse(_position.x, _position.y, 1.0f, 1.0f);
    }
    pop();

    if (__DEBUG__) {
      push();
      textSize(20);
      text(
        String.format("POS: (%.2f, %.2f)", _position.x, _position.y),
        20,
        height - 40
      );
      text(
        String.format("VEL: (%.2f, %.2f)", _velocity.x, _velocity.y),
        20,
        height - 20
      );
      pop();
    }
  }
}
