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
  // Body variables
  float bodyMaxWidth = width * 0.45;
  float bodyMinWidth = bodyMaxWidth / 2;
  float bodyHeight = height * 0.4;
  float bodyX = ((width - bodyMaxWidth) / 2);
  float bodyY = ((height - bodyHeight) / 2);
  bodyY += bodyY * OFFSET_Y_MULTIPLE;

  // Head variables
  float headDiameter = width * 0.3;

  // Paw variables
  float pawWidth = bodyMaxWidth * 0.3;
  float pawHeight = (float)UNIT * 2;

  { // START BODY
    push();
    translate(bodyX, bodyY);
    drawBody(bodyMinWidth, bodyMaxWidth, bodyHeight);

    { // START BODY.HEAD
      push();
      float translateHeadX = (bodyMaxWidth - headDiameter) / 2;
      float translateHeadY = -1 * (headDiameter / 2);

      translate(translateHeadX, translateHeadY);
      drawHead(headDiameter);
      pop();
    } // END BODY.HEAD

    { // START BODY.PAWS
      push();
      float translateLeftPawX = -1 * (pawWidth / 2);
      float translateRightPawX = bodyMaxWidth;
      float translatePawY = bodyHeight - (pawHeight / 2);

      translate(translateLeftPawX, translatePawY);
      drawPaw(pawWidth, pawHeight);
      translate(translateRightPawX, 0);
      drawPaw(pawWidth, pawHeight);
      pop();
    } // END BODY.PAWS

    pop();
  } // END BODY
}

void drawHead(float diameter) {
  float headWidth = diameter;
  float headHeight = diameter;
  float halfHeadWidth = headWidth / 2;
  float halfHeadHeight = headHeight / 2;

  { // START FACE
    push();
    fill(255);
    ellipse(0, 0, headWidth, headHeight);

    { // START FACE.EYES
      push();
      float eyeWidth = UNIT;
      float eyeHeight = UNIT / 2;
      float eyeY = (headHeight / 3);
      float leftEyeX = (halfHeadWidth) - eyeWidth;
      float rightEyeX = (halfHeadWidth) + eyeWidth;

      fill(0);
      ellipseMode(CENTER);
      ellipse(leftEyeX, eyeY, eyeWidth, eyeHeight);
      ellipse(rightEyeX, eyeY, eyeWidth, eyeHeight);
      pop();
    } // END FACE.EYES

    { // START FACE.NOSE
      push();
      float noseWidth = UNIT;
      float noseHeight = UNIT;
      float noseTranslateX = halfHeadWidth - (noseWidth / 2);
      float noseTranslateY = halfHeadHeight;
      translate(noseTranslateX, noseTranslateY);

      { // START FACE.NOSE.WHISKERS
        push();
        float whiskersCount = 4;
        float whiskersWidth = noseWidth * 2.8;
        float whiskersHeight = noseHeight * 0.6;
        float whiskersSpacing = whiskersHeight / max(1, whiskersCount - 1);
        float whiskersTranslateX = (noseWidth - whiskersWidth) / 2;
        float whiskersTranslateY = (noseHeight - whiskersHeight) / 2;

        translate(whiskersTranslateX, whiskersTranslateY);
        stroke(0);

        for (int i = 0; i < whiskersCount; i++) {
          float whiskerY = i * whiskersSpacing;
          line(0, whiskerY, whiskersWidth, whiskerY);
        }

        pop();
      } // END FACE.NOSE.WHISKERS

      fill(255, 0, 0);
      triangle(0, 0, noseWidth, 0, noseWidth / 2, noseHeight);
      pop();
    } // END FACE.NOSE

    pop();
  } // END FACE
}

void drawBody(float topWidth, float bottomWidth, float myHeight) {
  float topLeftX = max(0, bottomWidth - topWidth) / 2;
  float topLeftY = 0;

  float topRightX = topLeftX + topWidth;
  float topRightY = 0;

  float bottomLeftX = max(0, topWidth - bottomWidth) / 2;
  float bottomLeftY = myHeight;

  float bottomRightX = bottomLeftX + bottomWidth;
  float bottomRightY = myHeight;

  push(); // START BODY
  fill(235);
  quad(topLeftX, topLeftY, topRightX, topRightY, bottomRightX, bottomRightY, bottomLeftX, bottomLeftY);
  pop(); // END BODY
}

void drawPaw(float myWidth, float myHeight) {
  push(); // START PAW
  fill(255);
  arc(0, 0, myWidth, myHeight, PI, TWO_PI);
  pop(); // END PAW
}
