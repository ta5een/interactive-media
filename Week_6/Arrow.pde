public class Arrow {
  private static final float SCALE = 10.0;
  private static final float ARROW_WIDTH = SCALE * 4.0;
  private static final float ARROW_HEIGHT = SCALE * 2.0;
  private final color ARROW_COLD_COLOR = color(53, 134, 184);
  private final color ARROW_HOT_COLOR = color(184, 53, 53);

  private PVector position = new PVector();
  private PVector velocity = new PVector();

  private final float arrowsSpacingX;
  private final float arrowsSpacingY;

  public Arrow(
    PVector initialPosition,
    float arrowsSpacingX,
    float arrowsSpacingY
  ) {
    this.position = initialPosition;
    this.arrowsSpacingX = arrowsSpacingX;
    this.arrowsSpacingY = arrowsSpacingY;
  }

  private void update(float direction, float gust) {
    this.velocity.x = cos(radians(direction));
    this.velocity.y = sin(radians(direction));
    this.velocity.mult(gust);
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

  public void draw(float direction, float gust, float temperature) {
    this.update(direction, gust);
    var fillLerp = map(temperature, MIN_TEMP, MAX_TEMP, 0.0, 1.0);
    var arrowColor = lerpColor(ARROW_COLD_COLOR, ARROW_HOT_COLOR, fillLerp);

    push();
    stroke(arrowColor);
    fill(arrowColor, int(255 * 0.4));
    translate(this.position.x, this.position.y);
    rotate(radians(direction));
    beginShape();
    vertex(ARROW_WIDTH * 0.5, 0.0);
    vertex(ARROW_WIDTH * -0.5, ARROW_HEIGHT * 1.0);
    vertex(ARROW_WIDTH * -0.25, 0.0);
    vertex(ARROW_WIDTH * -0.5, ARROW_HEIGHT * -1.0);
    endShape(CLOSE);
    pop();

    // Draw vector direction
    // if (__DEBUG__) {
    //   push();
    //   translate(this.position.x, this.position.y);
    //   stroke(255, 0, 0, 100);
    //   line(0, 0, this.velocity.x * 10, this.velocity.y * 10);
    //   pop();
    // }
  }
}
