static final int UNIT = 30;
static final float OFFSET_Y_MULTIPLE = 0.25;

void settings() {
  size(UNIT * 20, UNIT * 20);
}

void setup() {
  background(0);
  noStroke();
  ellipseMode(CORNER);
  drawCat();
}

void drawCat() {
  float bodyMaxWidth = width * 0.4;
  float bodyMinWidth = bodyMaxWidth / 2;
  float bodyHeight = height * 0.45;
  float bodyX = ((width - bodyMaxWidth) / 2);
  float bodyY = ((height - bodyHeight) / 2);
  bodyY += bodyY * OFFSET_Y_MULTIPLE;

  float headDiameter = width * 0.3;
  float headX = (width - headDiameter) / 2;
  float headY = bodyY - (headDiameter / 2);

  float pawWidth = bodyMaxWidth * 0.3;
  float pawHeight = (float)UNIT * 2;
  float pawY = (bodyY + bodyHeight) - (pawHeight / 2);
  float leftPawX = bodyX - (pawWidth / 2);
  float rightPawX = (bodyX + bodyMaxWidth) - (pawWidth / 2);

  fill(235);
  drawBody(bodyX, bodyY, bodyMinWidth, bodyMaxWidth, bodyHeight);

  fill(255);
  drawHead(headX, headY, headDiameter);

  fill(255);
  drawPaw(leftPawX, pawY, pawWidth, pawHeight);
  drawPaw(rightPawX, pawY, pawWidth, pawHeight);
}

void drawHead(float x, float y, float diameter) {
  float headWidth = diameter;
  float headHeight = diameter;
  ellipse(x, y, headWidth, headHeight);

  // Start CENTER ellipse mode
  ellipseMode(CENTER);

  float halfHeadWidth = headWidth / 2;
  float halfHeadHeight = headHeight / 2;

  float eyeWidth = UNIT;
  float eyeHeight = UNIT / 2;
  float eyeY = y + (headHeight / 3);
  float leftEyeX = (x + halfHeadWidth) - eyeWidth;
  float rightEyeX = (x + halfHeadWidth) + eyeWidth;

  fill(0);
  ellipse(leftEyeX, eyeY, eyeWidth, eyeHeight);
  ellipse(rightEyeX, eyeY, eyeWidth, eyeHeight);

  // End CENTER ellipse mode
  ellipseMode(CORNER);

  float noseWidth = UNIT;
  float noseHeight = UNIT;
  float noseX = x + (halfHeadWidth - (noseWidth / 2));
  float noseY = y + (halfHeadHeight * 1);

  float noseTopLeftX = noseX;
  float noseTopLeftY = noseY;
  float noseTopRightX = noseX + noseWidth;
  float noseTopRightY = noseY;
  float noseBottomX = x + halfHeadWidth;
  float noseBottomY = noseY + noseHeight;

  fill(255, 0, 0);
  triangle(noseTopLeftX, noseTopLeftY, noseTopRightX, noseTopRightY, noseBottomX, noseBottomY);
}

void drawBody(float x, float y, float topWidth, float bottomWidth, float myHeight) {
  float topLeftX = x + max(0, bottomWidth - topWidth) / 2;
  float topLeftY = y;

  float topRightX = topLeftX + topWidth;
  float topRightY = y;

  float bottomLeftX = x + max(0, topWidth - bottomWidth) / 2;
  float bottomLeftY = y + myHeight;

  float bottomRightX = bottomLeftX + bottomWidth;
  float bottomRightY = y + myHeight;

  quad(topLeftX, topLeftY, topRightX, topRightY, bottomRightX, bottomRightY, bottomLeftX, bottomLeftY);
}

void drawPaw(float x, float y, float myWidth, float myHeight) {
  arc(x, y, myWidth, myHeight, PI, TWO_PI);
}
