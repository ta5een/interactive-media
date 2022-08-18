// Week 3 (Animate the Mouse Pointer)
// Author: Mohammed Ta-Seen Islam (13215660)

// ------------------------- CONFIGURABLE VARIABLES ----------------------------

// The number of sides of the star that follows the mouse
int starSideCount = 8;

// The increment value when scaling the star
float starScaleInc = 0.1;
// The minimum scale when shrinking the star
float minStarScale = 0.4;
// The maximum scale when growing the star
float maxStarScale = 1.0;

// The increment value when rotating the star
float starRotInc = 0.5;
// The minimum delta when slowing down the rotation of the star
float minStarRotDelta = 0.5;
// The maximum delta when speeding the rotation of the star
float maxStarRotDelta = 2.5;

// The increment value when transition the color of the star
float starColorInc = starScaleInc;
// The background color
color backgroundColor = color(38, 38, 38, 50);
// The star's fill color when calm
color starCalmColor = color(84, 255, 255);
// The star's fill color when agitated
color starAgitatedColor = color(255, 101, 84);

// ------------------------ INTERNAL STATE VARIABLES ---------------------------

float _starScale = 1.0;
float _starRotDelta = 1.0;
float _starRotAngle = 0.0;
color _starColor = starCalmColor;
float _starColorDelta = 0.0;

// ------------------------------- FUNCTIONS -----------------------------------

void setup() {
  size(800, 800);
  noStroke();
}

void draw() {
  // Draw a transparent background behind the star to give that "ghost" effect
  push();
  fill(backgroundColor);
  rect(0, 0, width, height);
  pop();

  // Star radius sizes
  // Here, `starOuterRadius` is multiplied by `starScale` to allow variables
  // that depend on it (such as `translateX` and `translateY`) to be
  // recalculated to reflect the new scaled size
  float starOuterRadius = width * 0.15 * _starScale;
  float starInnerRadius = starOuterRadius * 0.8;

  // Defining the min and max constraints of the star's translation
  float starMinX = starOuterRadius;
  float starMinY = starOuterRadius;
  float starMaxX = width - starOuterRadius;
  float starMaxY = width - starOuterRadius;

  // Translate the star to the mouse's current x and y position, but don't let
  // the polygon escape the window.
  float translateX = constrain(mouseX, starMinX, starMaxX);
  float translateY = constrain(mouseY, starMinY, starMaxY);

  // Calculate the star's scale
  // If the mouse is pressed, we'll decrease the scale by `starScaleInc` until
  // we hit `minStarScale`. Otherwise, if the mouse is not pressed, revert back
  // to the default scale of `1.0`.
  if (mousePressed) {
    _starScale = max(minStarScale, _starScale - starScaleInc);
    _starRotDelta = min(maxStarRotDelta, _starRotDelta + starRotInc);
    _starColorDelta = min(1.0, _starColorDelta + starColorInc);
  } else if (_starScale < 1.0 || _starColorDelta > 0.0) {
    _starScale = min(maxStarScale, _starScale + starScaleInc);
    _starRotDelta = max(minStarRotDelta, _starRotDelta - starRotInc);
    _starColorDelta = max(0.0, _starColorDelta - starColorInc);
  }

  // Draw the star after translating and rotating the drawing context
  push();
  translate(translateX, translateY);
  rotate(radians(_starRotAngle));
  fill(lerpColor(starCalmColor, starAgitatedColor, _starColorDelta));
  star(starSideCount, starOuterRadius, starInnerRadius);
  pop();

  // Continue rotating by adding the delta (determines its rotation speed)
  _starRotAngle += _starRotDelta;
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