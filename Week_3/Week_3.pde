float rotationAngle = 0.0;

void setup() {
  size(600, 600);
}

void draw() {
  float polygonRadius = width / 10;

  float minX = polygonRadius;
  float minY = polygonRadius;
  float maxX = width - polygonRadius;
  float maxY = height - polygonRadius;

  float translateX = constrain(mouseX, minX, maxX);
  float translateY = constrain(mouseY, minY, maxY);

  background(0);
  translate(translateX, translateY);
  rotate(radians(rotationAngle));
  drawPolygon(7, polygonRadius);

  rotationAngle++;
}

void drawPolygon(int sides, float radius) {
  beginShape();
  int increment = 360 / sides;
  for (int angle = 0; angle < 360; angle += increment) {
    float x = radius * cos(radians(angle));
    float y = radius * sin(radians(angle));
    vertex(x, y);
  }
  endShape(CLOSE);
}
