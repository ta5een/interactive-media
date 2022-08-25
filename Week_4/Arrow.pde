public class Arrow {

  private final float scale = width * 0.02;
  private final float acceleration = 3.0;

  private float theta = 0.0;
  private PVector position = new PVector();
  private PVector velocity = new PVector();

  private float lerpProgress = 0.0;
  private float prevDirection = 0.0;
  private float currDirection = 0.0;

  public Arrow(PVector startingPosition) {
    position = startingPosition;
  }

  public void turn(float direction) {
    this.prevDirection = this.currDirection;
    this.currDirection = direction;
    this.lerpProgress = 0.0;
  }

  private void update() {
    this.lerpProgress = (float(frameCount) / stepByFrameRate) % 1.0;
    this.theta = lerp(this.prevDirection, this.currDirection, this.lerpProgress);

    this.velocity.x = cos(radians(this.theta));
    this.velocity.y = sin(radians(this.theta));
    this.velocity.mult(this.acceleration);

    this.position.add(velocity);
    this.position.x = ((position.x % width) + width) % width;
    this.position.y = ((position.y % height) + height) % height;
  }

  public void draw() {
    this.update();

    push();
    stroke(255);
    fill(255, 255, 255, 100);
    translate(this.position.x, this.position.y);

    rotate(radians(this.theta));
    beginShape();
    vertex(this.scale * 2.0, 0.0);
    vertex(this.scale * -2.0, this.scale * 1.0);
    vertex(this.scale * -2.0, this.scale * -1.0);
    endShape(CLOSE);
    pop();

    if (__DEBUG__) {
      // Draw vector direction
      push();
      translate(this.position.x, this.position.y);
      stroke(255, 0, 0);
      line(0, 0, this.velocity.x * 10, this.velocity.y * 10);
      pop();

      // Write out current state
      push();
      textSize(15);
      text(String.format("%s @ %.2f°", this.velocity, this.theta), 10, height - 30);
      text(String.format("%.2f° -> %.2f° (%.2f)", this.prevDirection, this.currDirection, this.lerpProgress), 10, height - 10);
      pop();
    }
  }

}
