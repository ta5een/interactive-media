// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

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
