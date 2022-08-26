public class ArrowGrid {

  private Table windDirTable;
  private int windDirTableRowCount = 0;
  private int currWindDirTableIndex = 0;

  private Table windGustTable;
  private int windGustTableRowCount = 0;
  private int currWindGustTableIndex = 0;

  private final ArrayList<Arrow> arrows = new ArrayList();
  private float currDir = 0.0;
  private float currGust = 0.0;
  private boolean shouldChange = false;

  private final int numCols;
  private final int numRows;

  public ArrowGrid (Table windDirTable, Table windGustTable, int numCols, int numRows) {
    this.windDirTable = windDirTable;
    this.windDirTableRowCount = windDirTable.getRowCount();
    this.currDir = windDirTable.getFloat(this.currWindDirTableIndex, 1);

    this.windGustTable = windGustTable;
    this.windGustTableRowCount = windDirTable.getRowCount();
    this.currGust = windGustTable.getFloat(this.currWindGustTableIndex, 1);

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
        arrow.changeDirectionAndSpeed(this.currDir, this.currGust);
        arrows.add(arrow);
      }
    }
  }

  public void draw() {
    if (frameCount == 1 || frameCount % UPDATE_EVERY_FRAME_RATE == 0) {
      this.currDir = this.windDirTable.getFloat(this.currWindDirTableIndex, 1);
      this.currWindDirTableIndex = (this.currWindDirTableIndex + 1) % this.windDirTableRowCount;

      this.currGust = this.windGustTable.getFloat(this.currWindGustTableIndex, 1);
      this.currWindGustTableIndex = (this.currWindGustTableIndex + 1) % this.windGustTableRowCount;

      this.shouldChange = true;
    }

    for (Arrow arrow : this.arrows) {
      if (shouldChange) {
        arrow.changeDirectionAndSpeed(this.currDir, this.currGust);
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
