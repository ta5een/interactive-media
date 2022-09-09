public class ArrowGrid {
  private final ArrayList<Arrow> arrows = new ArrayList();
  private float currDir = 0.0;
  private float currGust = 0.0;
  private boolean shouldChange = false;

  private final int numCols;
  private final int numRows;

  public ArrowGrid(int numCols, int numRows) {
    this.numCols = numCols;
    this.numRows = numRows;

    var arrowsSpacingX = width / (this.numCols - 1);
    var arrowsSpacingY = height / (this.numRows - 1);
    var topLeft = new PVector();

    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < numCols; col++) {
        var position = topLeft.copy();
        position.x += (arrowsSpacingX * col);
        position.y += (arrowsSpacingY * row);

        var arrow = new Arrow(position, arrowsSpacingX / 2, arrowsSpacingY / 2);
        arrow.changeDirection(this.currDir);
        arrow.changeGust(this.currGust);
        arrows.add(arrow);
      }
    }
  }

  public void draw() {
    for (Arrow arrow : this.arrows) {
       if (shouldChange) {
         arrow.changeDirection(this.currDir);
         arrow.changeGust(this.currGust);
       }
      arrow.draw();
    }

     shouldChange = false;

    if (__DEBUG__) {
      // Write out current gust and direction at the bottom left of the window
      push();
      textSize(25);
      fill(0);
      text(String.format("Wind Gust: %.2f km/h", this.currGust), 20, height - 60);
      text(String.format("Wind Direction: %.2f°", this.currDir), 20, height - 20);
      pop();
    }
  }
}
