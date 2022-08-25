// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

static final boolean __DEBUG__ = true;
static final int STEP_EVERY_FRAME_RATE = 60;

Table table;
int rowCount = 0;
int currIndex = 0;

ArrayList<Arrow> arrows = new ArrayList();
float currDirection = 0.0;
boolean shouldTurn = false;

void setup() {
  size(1280, 720);
  background(20);

  table = loadTable("wind_direction.csv", "csv");
  rowCount = table.getRowCount();
  currDirection = table.getFloat(0, 1);

  var numCols = 12;
  var numRows = 8;
  var arrowsSpacingX = width / (numCols - 1);
  var arrowsSpacingY = height / (numRows - 1);
  var topLeft = new PVector();

  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      var position = topLeft.copy();
      position.x += (arrowsSpacingX * col);
      position.y += (arrowsSpacingY * row);

      var arrow = new Arrow(position, arrowsSpacingX / 2, arrowsSpacingY / 2);
      arrow.turn(currDirection);
      arrows.add(arrow);
    }
  }
}

void draw() {
  if (frameCount % STEP_EVERY_FRAME_RATE == 0) {
    currIndex = (currIndex + 1) % rowCount;
    currDirection = table.getFloat(currIndex, 1);
    shouldTurn = true;
  }

  background(20);
  for (var arrow : arrows) {
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
