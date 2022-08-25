// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

static final boolean __DEBUG__ = true;
static final int stepByFrameRate = 80;

PaperPlane plane;

Table table;
int rowCount = 0;
int currIndex = 0;

void setup() {
  size(400, 400);
  table = loadTable("wind_direction.csv", "csv");
  rowCount = table.getRowCount();
  plane = new PaperPlane(new PVector(width / 2, height / 2));
}

void draw() {
  if (frameCount % stepByFrameRate == 0) {
    currIndex = (currIndex + 1) % rowCount;
    float newDirection = table.getFloat(currIndex, 1);
    plane.turn(newDirection);
  }

  background(0);
  plane.draw();
}
