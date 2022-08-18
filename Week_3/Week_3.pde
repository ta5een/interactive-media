// The number of sides of the polygon that follows the mouse
int polygonSideCount = 7;
// Determines the starting rotation angle
float rotationAngle = 0.0;
// Determines the speed of the rotation
float rotationDelta = 2.0;

void setup() {
  size(600, 600);
}

void draw() {
  // Polygon variables
  float polygonRadius = width / 10;
  float polygonMinX = polygonRadius;
  float polygonMinY = polygonRadius;
  float polygonMaxX = width - polygonRadius;
  float polygonMaxY = height - polygonRadius;

  // Translate the polygon to the mouse's current x and y position, but don't
  // let the polygon escape the window.
  float translateX = constrain(mouseX, polygonMinX, polygonMaxX);
  float translateY = constrain(mouseY, polygonMinY, polygonMaxY);

  background(0);
  translate(translateX, translateY);
  rotate(radians(rotationAngle));
  drawPolygon(polygonSideCount, polygonRadius);

  rotationAngle += rotationDelta;
}

/**
 * Draws a polygon with the given number of sides and radius (to determine its
 * width and height).
 */
void drawPolygon(int sideCount, float radius) {
  beginShape();
  int increment = 360 / sideCount;
  for (int angle = 0; angle < 360; angle += increment) {
    float x = radius * cos(radians(angle));
    float y = radius * sin(radians(angle));
    vertex(x, y);
  }
  endShape(CLOSE);
}
