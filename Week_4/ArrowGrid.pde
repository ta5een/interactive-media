public class ArrowGrid {

  private Table table;
  private int tableRowCount = 0;
  private int currTableIndex = 0;

  private ArrayList<Arrow> arrows = new ArrayList();
  private float currDirection = 0.0;
  private boolean shouldTurn = false;

  private final int numCols;
  private final int numRows;

  public ArrowGrid (Table table, int numCols, int numRows) {
    this.table = table;
    this.tableRowCount = table.getRowCount();
    this.currDirection = table.getFloat(this.currTableIndex, 1);

    this.numCols = numCols;
    this.numRows = numRows;

    var arrowsSpacingX = width / (this.numCols - 1);
    var arrowsSpacingY = height / (this.numRows - 1);
    var topLeft = new PVector();

    for (int row = 0; row < numRows; row++ ) {
      for (int col = 0; col < numCols; col++) {
        var position = topLeft.copy();
        position.x += (arrowsSpacingX * col);
        position.y += (arrowsSpacingY * row);

        var arrow = new Arrow(position, arrowsSpacingX / 2, arrowsSpacingY / 2);
        arrow.turn(this.currDirection);
        arrows.add(arrow);
      }
    }
  }

  public void draw() {
    if (frameCount % STEP_EVERY_FRAME_RATE == 0) {
      this.currTableIndex = (this.currTableIndex + 1) % this.tableRowCount;
      this.currDirection = this.table.getFloat(this.currTableIndex, 1);
      this.shouldTurn = true;
    }

    for (Arrow arrow : this.arrows) {
      if (shouldTurn) arrow.turn(currDirection);
      arrow.draw();
    }

    shouldTurn = false;

    if (__DEBUG__) {
      // Write out current direction at the bottom left of the window
      push();
      textSize(25);
      text(String.format("%.2f°", currDirection), 20, height - 20);
      pop();
    }
  }

}
