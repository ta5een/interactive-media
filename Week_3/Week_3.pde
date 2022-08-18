// The number of sides of the polygon that follows the mouse
int polygonSideCount = 7;
// Determines the starting rotation angle
float rotationAngle = 0.0;
// Determines the speed of the rotation
float rotationDelta = 0.2;

void setup() {
  size(800, 800);
  noStroke();
  rectMode(CENTER);
}

void draw() {
  background(0);

  // Star variables
  float starOuterRadius = width * 0.1;
  float starInnerRadius = starOuterRadius * 0.85;

  // Defining the min and max constraints of the star's translation
  float starMinX = starOuterRadius;
  float starMinY = starOuterRadius;
  float starMaxX = width - starOuterRadius;
  float starMaxY = width - starOuterRadius;

  // Translate the star to the mouse's current x and y position, but don't let
  // the polygon escape the window.
  float translateX = constrain(mouseX, starMinX, starMaxX);
  float translateY = constrain(mouseY, starMinY, starMaxY);

  // Draw the star after translating and rotating the drawing context
  push();
  translate(translateX, translateY);
  rotate(radians(rotationAngle));
  star(7, starOuterRadius, starInnerRadius);
  pop();

  // Continue rotating by adding the delta (determines its rotation speed)
  rotationAngle += rotationDelta;
}

/**
 * Draws a polygon with the given number of sides and radius (to determine its
 * width and height).
 */
void polygon(int sideCount, float radius) {
  beginShape();

  float theta = 0.0;
  float thetaInc = TWO_PI / sideCount;
  float x = 0.0;
  float y = 0.0;

  for (int i = 0; i < sideCount; i++) {
    x = cos(theta) * radius;
    y = sin(theta) * radius;
    vertex(x, y);
    theta += thetaInc;
  }

  endShape(CLOSE);
}

/**
 * Draws a star with the given number of points, inner radius and outer radius.
 *
 * The `innerRadius` and `outerRadius` defines the zig-zag path of the star's
 * shape. The more closer `innerRadius` is to `outerRadius`, the more the star
 * will look like a regular polygon with `pointCount` sides.
 */
void star(int pointCount, float innerRadius, float outerRadius) {
  beginShape();

  // The number of vertexes the draw will always be double the number of points.
  float vertexCount = pointCount * 2;

  // `theta` is the current size of the angle which will determine the x and y
  // coordinates of the current vertex. It will be incremented by `thetaInc` on
  // every new vertex we want to draw.
  float theta = 0.0;
  float thetaInc = TWO_PI / vertexCount;

  // Temporary x and y values that will be incremented until we finish drawing
  // the shape.
  float x = 0.0;
  float y = 0.0;

  // Draw the vertexes by alternating between the outer and inner radii as we
  // make a full rotation.
  for (int i = 0; i < vertexCount; i++) {
    float radius = i % 2 == 0 ? outerRadius : innerRadius;
    x = cos(theta) * radius;
    y = sin(theta) * radius;
    vertex(x, y);
    theta += thetaInc;
  }

  endShape(CLOSE);
}
