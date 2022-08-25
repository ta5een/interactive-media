public class Arrow {

  private final float scale = width * 0.02;
  private final float acceleration = 2.0;

  private float rotation = 0.0;
  private PVector position = new PVector();
  private PVector velocity = new PVector();

  private float lerpProgress = 0.0;
  private float prevDirection = 0.0;
  private float currDirection = 0.0;

  public Arrow(PVector startingPosition) {
    position = startingPosition;
  }

  public float getDirection() {
    return this.currDirection;
  }

  public void turn(float direction) {
    this.prevDirection = this.currDirection;
    this.currDirection = direction;
    this.lerpProgress = 0.0;
  }

  private void update() {
    this.lerpProgress = (float(frameCount) / stepByFrameRate) % 1.0;
    this.rotation = lerp(this.prevDirection, this.currDirection, this.lerpProgress);

    // velocity.x = cos(rotation);
    // velocity.y = sin(rotation);
    // velocity.mult(acceleration);

    // position.add(velocity);
    // position.x = ((position.x % width) + width) % width;
    // position.y = ((position.y % width) + width) % width;
    // println(position, velocity);
  }

  public void draw() {
    this.update();

    push();
    noFill();
    stroke(255);
    translate(this.position.x, this.position.y);

    push();
    fill(0, 255, 0);
    circle(0.0, 0.0, width * 0.005);
    pop();

    rotate(radians(this.rotation));
    beginShape();
    vertex(this.scale * 2.0, 0.0);
    vertex(this.scale * -2.0, this.scale * 1.0);
    vertex(this.scale * -2.0, this.scale * -1.0);
    endShape(CLOSE);
    pop();

    if (__DEBUG__) {
      push();
      textSize(20);
      text(
        String.format(
        "%.2f° -> %.2f° (%.2f)",
        this.prevDirection,
        this.currDirection,
        this.lerpProgress
        ),
        10,
        height - 10
        );
      pop();
    }
  }
}
