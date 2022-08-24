public class PaperPlane {

  private float scale = width * 0.02;
  private float acceleration = 3.0;

  private PVector position;
  private PVector velocity = new PVector();

  public PaperPlane(PVector startingPosition) {
    position = startingPosition;
  }

  public void draw(float rotation) {
    velocity.x = cos(rotation);
    velocity.y = sin(rotation);
    velocity.mult(acceleration);

    position.add(velocity);
    position.x = ((position.x % width) + width) % width;
    position.y = ((position.y % width) + width) % width;
    // println(position, velocity);

    push();
    noFill();
    stroke(255);
    translate(position.x, position.y);

    push();
    fill(0, 255, 0);
    circle(0.0, 0.0, width * 0.005);
    pop();

    rotate(rotation);
    beginShape();
    vertex(scale * 2.0, 0.0);
    vertex(scale * -2.0, scale * 1.0);
    vertex(scale * -2.0, scale * -1.0);
    endShape(CLOSE);
    pop();
  }

}
