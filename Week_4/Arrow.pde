public class Arrow {

  private static final float SCALE = 10;
  private static final float WIDTH = SCALE * 4.0;
  private static final float HEIGHT = SCALE * 2.0;
  private final color ARROW_COLOR = color(53, 66, 184);

  private float speed = 0.0;
  private float theta = 0.0;
  private PVector position = new PVector();
  private PVector velocity = new PVector();

  private float lerpProgress = 0.0;
  private float prevDirection = 0.0;
  private float currDirection = 0.0;
  private float prevGust = 0.0;
  private float currGust = 1.0;

  private final float arrowsSpacingX;
  private final float arrowsSpacingY;

  public Arrow(PVector position) {
    this.position = position;
    this.arrowsSpacingX = 0.0;
    this.arrowsSpacingY = 0.0;
  }

  public Arrow(PVector position, float arrowsSpacingX, float arrowsSpacingY) {
    this.position = position;
    this.arrowsSpacingX = arrowsSpacingX;
    this.arrowsSpacingY = arrowsSpacingY;
  }

  public void changeDirectionAndGust(float direction, float speed) {
    this.prevDirection = this.currDirection;
    this.currDirection = direction;
    this.prevGust = this.currGust;
    this.currGust = speed;
    this.lerpProgress = 0.0;
  }

  private void update() {
    this.lerpProgress = (float(frameCount) / UPDATE_EVERY_FRAME_RATE) % 1.0;
    this.theta = lerp(this.prevDirection, this.currDirection, this.lerpProgress);
    this.speed = lerp(this.prevGust, this.currGust, this.lerpProgress);

    this.velocity.x = cos(radians(this.theta));
    this.velocity.y = sin(radians(this.theta));
    this.velocity.mult(this.speed);
    this.position.add(velocity);

    var boundsMinX = int(-this.arrowsSpacingX);
    var boundsMaxX = int(width + this.arrowsSpacingX);
    var boundsMinY = int(-this.arrowsSpacingY);
    var boundsMaxY = int(height + this.arrowsSpacingY);

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
    stroke(ARROW_COLOR);
    fill(ARROW_COLOR, int(255 * 0.4));
    translate(this.position.x, this.position.y);

    rotate(radians(this.theta));
    beginShape();
    vertex(WIDTH * 0.5, 0.0);
    vertex(WIDTH * -0.5, HEIGHT * 1.0);
    vertex(WIDTH * -0.25, 0.0);
    vertex(WIDTH * -0.5, HEIGHT * -1.0);
    endShape(CLOSE);
    pop();

    // if (__DEBUG__) {
    //   // Draw vector direction
    //   push();
    //   translate(this.position.x, this.position.y);
    //   stroke(255, 0, 0, 100);
    //   line(0, 0, this.velocity.x * 10, this.velocity.y * 10);
    //   pop();
    // }
  }
}
