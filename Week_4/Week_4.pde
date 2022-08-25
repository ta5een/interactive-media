// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

static final boolean __DEBUG__ = true;
static final int STEP_EVERY_FRAME_RATE = 60;

Table table;
int rowCount = 0;
int currIndex = 0;

ArrayList<Arrow> arrows = new ArrayList();
float currDirection = 0.0;

void setup() {
  size(1280, 720);
  background(20);

  table = loadTable("wind_direction.csv", "csv");
  rowCount = table.getRowCount();
  currDirection = table.getFloat(0, 1);

  PVector topLeft = new PVector();
  int numCols = 12;
  float arrowsSpacingX = width / (numCols - 1);

  int numRows = 8;
  float arrowsSpacingY = height / (numRows - 1);

  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      PVector position = topLeft.copy();
      position.x += (arrowsSpacingX * col);
      position.y += (arrowsSpacingY * row);

      Arrow arrow = new Arrow(position, arrowsSpacingX / 2, arrowsSpacingY / 2);
      arrow.turn(currDirection);
      arrows.add(arrow);
    }
  }
}

void draw() {
  if (frameCount % STEP_EVERY_FRAME_RATE == 0) {
    currIndex = (currIndex + 1) % rowCount;
    currDirection = table.getFloat(currIndex, 1);
    for (Arrow arrow : arrows) {
      arrow.turn(currDirection);
    }
  }

  background(20);
  for (Arrow arrow : arrows) {
    arrow.draw();
  }

  if (__DEBUG__) {
    // Write out current direction at the bottom left of the window
    push();
    textSize(25);
    text(String.format("%.2f°", currDirection), 20, height - 20);
    pop();
  }
}
