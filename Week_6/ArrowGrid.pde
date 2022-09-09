public class ArrowGrid {
  private final ArrayList<Arrow> arrows = new ArrayList();
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
        arrows.add(arrow);
      }
    }
  }

  public void draw(float direction, float gust, float temperature) {
    for (Arrow arrow : this.arrows) {
      arrow.draw(direction, gust, temperature);
    }

    // Write out current gust and direction at the bottom left of the window
    if (__DEBUG__) {
      push();
      textSize(25);
      fill(0);
      text(String.format("Air Temp: %.2f°C", temperature), 20, height - 100);
      text(String.format("Wind Gust: %.2f m/s", gust), 20, height - 60);
      text(String.format("Wind Direction: %.2f°", direction), 20, height - 20);
      pop();
    }
  }
}
