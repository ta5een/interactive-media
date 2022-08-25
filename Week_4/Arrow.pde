public class Arrow {

  private static final float SCALE = 10;
  private static final float WIDTH = SCALE * 4.0;
  private static final float HEIGHT = SCALE * 2.0;
  private static final float SPEED = 2.0;

  private float theta = 0.0;
  private PVector position = new PVector();
  private PVector velocity = new PVector();

  private float lerpProgress = 0.0;
  private float prevDirection = 0.0;
  private float currDirection = 0.0;

  private float arrowsSpacingX = 0.0;
  private float arrowsSpacingY = 0.0;

  public Arrow(PVector position) {
    this.position = position;
  }

  public Arrow(PVector position, float arrowsSpacingX, float arrowsSpacingY) {
    this.position = position;
    this.arrowsSpacingX = arrowsSpacingX;
    this.arrowsSpacingY = arrowsSpacingY;
  }

  public void turn(float direction) {
    this.prevDirection = this.currDirection;
    this.currDirection = direction;
    this.lerpProgress = 0.0;
  }

  private void update() {
    this.lerpProgress = (float(frameCount) / STEP_EVERY_FRAME_RATE) % 1.0;
    this.theta = lerp(this.prevDirection, this.currDirection, this.lerpProgress);

    this.velocity.x = cos(radians(this.theta));
    this.velocity.y = sin(radians(this.theta));
    this.velocity.mult(SPEED);
    this.position.add(velocity);

    int boundsMinX = int(-this.arrowsSpacingX);
    int boundsMaxX = int(width + this.arrowsSpacingX);
    int boundsMinY = int(-this.arrowsSpacingY);
    int boundsMaxY = int(height + this.arrowsSpacingY);

    if (this.position.x < boundsMinX) {
      this.position.x = boundsMaxX;
    } else if (this.position.x > boundsMaxX) {
      this.position.x = boundsMinX;
    }

    if (this.position.y < boundsMinY) {
      this.position.y = boundsMaxY;
    } else if (this.position.y > boundsMaxY) {
      this.position.y = boundsMinY;
    }
  }

  public void draw() {
    this.update();

    push();
    stroke(255);
    fill(255, 255, 255, 100);
    translate(this.position.x, this.position.y);

    rotate(radians(this.theta));
    beginShape();
    vertex(WIDTH * 0.5, 0.0);
    vertex(WIDTH * -0.5, HEIGHT * 0.5);
    vertex(WIDTH * -0.5, HEIGHT * -0.5);
    endShape(CLOSE);
    pop();

    if (__DEBUG__) {
      // Draw vector direction
      push();
      translate(this.position.x, this.position.y);
      stroke(255, 0, 0, 100);
      line(0, 0, this.velocity.x * 10, this.velocity.y * 10);
      pop();
    }
  }
}
