// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

PaperPlane plane;
float currRotation = 0.0;

void setup() {
  size(400, 400);
  plane = new PaperPlane(new PVector(width / 2, height / 2));
}

void draw() {
  background(0);
  plane.draw(radians(currRotation));
}

void keyPressed() {
  if (key == 'w' || key == 'a') {
    currRotation -= 10.0;
  } else if (key == 's' || key == 'd') {
    currRotation += 10.0;
  }
}

/*
Table table;
int currIndex = 0;

void setup() {
  size(800, 800);
  table = loadTable("wind_direction.csv", "csv");
}

void draw() {
  background(0);
  float currDirection = table.getFloat(currIndex, 1);
  float currRadians = radians(currDirection);
  currIndex = (currIndex + 1) % table.getRowCount();
}
*/
