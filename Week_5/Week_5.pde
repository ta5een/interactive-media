// Week 5 (Develop a graphical user interface for an existing sketch)
// Author: Mohammed Ta-Seen Islam (13215660)

static final boolean __DEBUG__ = true;
//static final int UPDATE_EVERY_FRAME = 60;

ArrowGrid arrowGrid;
final int numCols = 8;
final int numRows = 6;

void setup() {
  size(1080, 607);
  background(255);
  arrowGrid = new ArrowGrid(numCols, numRows);
}

void draw() {
  background(255);
  arrowGrid.draw();
}
