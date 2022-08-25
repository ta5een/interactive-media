// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

static final boolean __DEBUG__ = true;
static final int stepByFrameRate = 80;

Table table;
int rowCount = 0;
int currIndex = 0;

Arrow arrow;
float currDirection = 0.0;

void setup() {
  size(400, 400);
  table = loadTable("wind_direction.csv", "csv");
  rowCount = table.getRowCount();

  currDirection = table.getFloat(0, 1);
  arrow = new Arrow(new PVector(width / 2, height / 2));
  arrow.turn(currDirection);
}

void draw() {
  if (frameCount % stepByFrameRate == 0) {
    currIndex = (currIndex + 1) % rowCount;
    currDirection = table.getFloat(currIndex, 1);
    arrow.turn(currDirection);
  }

  background(20);
  arrow.draw();
}
