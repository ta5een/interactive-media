// Week 4 (Code an Animated Wallpaper)
// Author: Mohammed Ta-Seen Islam (13215660)

static final boolean __DEBUG__ = true;
static final int UPDATE_EVERY_FRAME_RATE = 60;

ArrowGrid arrowGrid;
final int numCols = 8;
final int numRows = 6;

final String windDirSource = "wind_direction.csv";
final String windGustSource = "peak_wind_gust.csv";

void setup() {
  size(1080, 607);
  background(255);

  Table windDirectionTable = loadTable(windDirSource, "csv");
  Table windGustTable = loadTable(windGustSource, "csv");
  arrowGrid = new ArrowGrid(windDirectionTable, windGustTable, numCols, numRows);
}

void draw() {
  background(255);
  arrowGrid.draw();
}
