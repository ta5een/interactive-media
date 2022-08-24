public class PaperPlane {

  private float scale;

  public PaperPlane() {
    scale = width * 0.02;
  }

  public void draw() {
    push();
    fill(255, 0, 0);
    circle(0, 0, width * 0.005);
    pop();

    push();
    noFill();
    stroke(255);
    beginShape();
    vertex(0, scale * -2);
    vertex(scale * -1, scale * 2);
    vertex(scale * 1, scale * 2);
    endShape(CLOSE);
    pop();
  }

}
