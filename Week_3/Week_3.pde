// Week 3 (Animate the Mouse Pointer)
// Author: Mohammed Ta-Seen Islam (13215660)

// ------------------------- CONFIGURABLE VARIABLES ----------------------------

// The number of sides of the star that follows the mouse
final int starSideCount = 8;

// The increment value when scaling the star
final float starScaleInc = 0.1;
// The minimum scale when shrinking the star
final float minStarScale = 0.4;
// The maximum scale when growing the star
final float maxStarScale = 1.0;

// The increment value when rotating the star
final float starRotInc = 0.5;
// The minimum rotation speed to slow down to when the star is "calm"
final float minStarRotDelta = 0.5;
// The maximum rotation speed to speed up to when the star is "agitated"
final float maxStarRotDelta = 2.5;

// The increment value when transitioning the star and background colour between
// the "calm" and "agitated" states
final float colorInc = starScaleInc;
// The background colour when the star is "calm" (slightly transparent to give
// that "ghost" effect)
final color backgroundCalmColor = color(38, 38, 38, 50);
// The background colour when the star is "agitated"
final color backgroundAgitatedColor = color(102, 82, 82, 50);
// The star's fill colour when "calm"
final color starCalmColor = color(84, 255, 255);
// The star's fill colour when "agitated"
final color starAgitatedColor = color(255, 101, 84);

// ------------------------ INTERNAL STATE VARIABLES ---------------------------

float _starScale = maxStarScale;
float _starRotDelta = minStarRotDelta;
float _starRotAngle = 0.0;
color _starColor = starCalmColor;
float _colorDelta = 0.0;

// ------------------------------- FUNCTIONS -----------------------------------

void setup() {
  size(800, 800);
  noStroke();
}

void draw() {
  // Star radius sizes
  // Here, `starOuterRadius` is multiplied by `_starScale` to allow variables
  // that depend on it (such as `translateX` and `translateY`) to be continuously
  // recalculated with the new scaled size
  final float starOuterRadius = width * 0.15 * _starScale;
  final float starInnerRadius = starOuterRadius * 0.8;

  // Defining the min and max constraints of the star's translation
  final float starMinX = starOuterRadius;
  final float starMinY = starOuterRadius;
  final float starMaxX = width - starOuterRadius;
  final float starMaxY = width - starOuterRadius;

  // Translate the star to the mouse's current x and y position while
  // constraining it to within the window's bounds
  final float translateX = constrain(mouseX, starMinX, starMaxX);
  final float translateY = constrain(mouseY, starMinY, starMaxY);

  // Calculate the star's scale, rotation delta and colour delta depending on
  // if the mouse is currently being pressed
  if (mousePressed) {
    // If the mouse is currently being pressed:
    // - decrease the scale until it reaches `minStarScale`;
    // - increase the rotation delta until it reaches `maxStarRotDelta`; and
    // - increase the colour delta until it reaches 1.0
    _starScale = max(minStarScale, _starScale - starScaleInc);
    _starRotDelta = min(maxStarRotDelta, _starRotDelta + starRotInc);
    _colorDelta = min(1.0, _colorDelta + colorInc);
  } else if (isStarAgitated()) {
    // Otherwise, if the star is still in the "agitated" state, transition to
    // the "calm" state:
    // - increase the scale until it reaches `maxStarScale`
    // - decrease the rotation delta until it reaches `minStarRotDelta`; and
    // - decrease the colour delta until it reaches 0.0
    _starScale = min(maxStarScale, _starScale + starScaleInc);
    _starRotDelta = max(minStarRotDelta, _starRotDelta - starRotInc);
    _colorDelta = max(0.0, _colorDelta - colorInc);
  }

  // Draw a transparent background behind the star to give that "ghost" effect
  push();
  fill(lerpColor(backgroundCalmColor, backgroundAgitatedColor, _colorDelta));
  rect(0, 0, width, height);
  pop();

  // Draw the star after translating and rotating the drawing context
  push();
  translate(translateX, translateY);
  rotate(radians(_starRotAngle));
  fill(lerpColor(starCalmColor, starAgitatedColor, _colorDelta));
  star(starSideCount, starOuterRadius, starInnerRadius);
  pop();

  // Continue rotating by adding the delta (determines its rotation speed)
  _starRotAngle += _starRotDelta;
}

/**
 * Determines whether or not the star is in the "agitated" state.
 *
 * This function will return `true` if the star is still shrunken and/or is
 * still red-ish in colour. It will return `false` once the scale and colour
 * return to their original values.
 */
boolean isStarAgitated() {
  return _starScale < maxStarScale || _colorDelta > 0.0;
}

/**
 * Draws a star with the given point count, inner radius and outer radius.
 *
 * The `innerRadius` and `outerRadius` defines the zig-zag path of the star's
 * shape. The more closer `innerRadius` is to `outerRadius`, the more the star
 * resembles a regular polygon with `pointCount` sides.
 */
void star(int pointCount, float innerRadius, float outerRadius) {
  beginShape();

  // The number of vertexes to draw will always be double the number of points.
  final float vertexCount = pointCount * 2;

  // `theta` is the current size of the angle which will determine the x and y
  // coordinates of the current vertex. It will be incremented by `thetaInc` on
  // every new vertex to draw.
  final float thetaInc = TWO_PI / vertexCount;
  float theta = 0.0;

  // Changing x and y values that will be continuously incremented until the
  // shape has finished drawing.
  float x = 0.0;
  float y = 0.0;

  // Draw the vertexes by alternating between the outer and inner radii as the
  // loop make a full rotation (2π radians or 360°).
  for (int i = 0; i < vertexCount; i++) {
    float radius = i % 2 == 0 ? outerRadius : innerRadius;
    x = cos(theta) * radius;
    y = sin(theta) * radius;
    vertex(x, y);
    theta += thetaInc;
  }

  endShape(CLOSE);
}

/**
 * Draws a polygon with the given side count and radius (to determine its width
 * and height).
 */
void polygon(int sideCount, float radius) {
  beginShape();

  final float thetaInc = TWO_PI / sideCount;
  float theta = 0.0;
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
