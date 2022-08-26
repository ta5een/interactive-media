// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

static final boolean __DEBUG__ = true;
static final int STEP_EVERY_FRAME_RATE = 60;

ArrowGrid arrowGrid;
int numCols = 12;
int numRows = 8;

void setup() {
  size(1280, 720);
  background(20);

  Table table = loadTable("wind_direction.csv", "csv");
  arrowGrid = new ArrowGrid(table, numCols, numRows);
}

void draw() {
  background(20);
  arrowGrid.draw();
}
