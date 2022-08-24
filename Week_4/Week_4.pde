// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

Table table;
int currIndex = 0;

PaperPlane plane;
float currDirection = 0.0;

void setup() {
  size(400, 400);
  table = loadTable("wind_direction.csv", "csv");
  plane = new PaperPlane(new PVector(width / 2, height / 2));
}

void draw() {
  if (frameCount % 40 == 0) {
    currDirection = table.getFloat(currIndex, 1);
  }

  background(0);
  plane.draw(radians(currDirection));

  textSize(20);
  text(String.format("%f°", currDirection), 10, height - 10);

  currIndex = (currIndex + 1) % table.getRowCount();
}
