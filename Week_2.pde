static final int UNIT = 30;
static final float OFFSET_Y_MULTIPLE = 0.25;

color catFaceColor = #FFFFFF;
color catBodyColor = #FFE999;
color catEyeColor = #FFFFFF;
color catPupilColor = #000000;
color catNoseColor = #FF6363;
color catEarColor = catBodyColor;
color catPawColor = catFaceColor;

void settings() {
  size(UNIT * 20, UNIT * 20);
}

void setup() {
  background(0);
  ellipseMode(CORNER);
  drawCat();
}

void drawCat() {
  // Body variables
  float bodyWidth = width * 0.5;
  float bodyHeight = height * 0.5;
  float bodyX = ((width - bodyWidth) / 2);
  float bodyY = ((height - bodyHeight) / 2);
  bodyY += bodyY * OFFSET_Y_MULTIPLE;

  // Head variables
  float headDiameter = bodyHeight * 0.65;

  // Paw variables
  float pawWidth = bodyWidth * 0.3;
  float pawHeight = bodyHeight * 0.3;

  { // START BODY
    push();
    translate(bodyX, bodyY);
    drawBody(bodyWidth, bodyHeight);

    { // START BODY.HEAD
      push();
      float translateHeadX = (bodyWidth - headDiameter) / 2;
      float translateHeadY = -1 * (headDiameter / 2);

      translate(translateHeadX, translateHeadY);
      drawHead(headDiameter);
      pop();
    } // END BODY.HEAD

    { // START BODY.PAWS
      push();
      float translateLeftPawX = -1 * (pawWidth / 2);
      float translateRightPawX = bodyWidth;
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
    fill(catFaceColor);
    ellipse(0, 0, headWidth, headHeight);

    { // START FACE.EYES
      push();
      float eyeWidth = headWidth * 0.2;
      float eyeHeight = eyeWidth;
      float pupilWidth = eyeWidth * 0.6;
      float pupilHeight = eyeWidth * 0.6;
      float eyeY = (headHeight / 3);
      float leftEyeX = (halfHeadWidth) - eyeWidth;
      float rightEyeX = (halfHeadWidth) + eyeWidth;

      fill(catEyeColor);
      ellipseMode(CENTER);
      ellipse(leftEyeX, eyeY, eyeWidth, eyeHeight);
      ellipse(rightEyeX, eyeY, eyeWidth, eyeHeight);

      fill(catPupilColor);
      ellipse(leftEyeX, eyeY, pupilWidth, pupilHeight);
      ellipse(rightEyeX, eyeY, pupilWidth,pupilHeight);

      pop();
    } // END FACE.EYES

    { // START FACE.NOSE+MOUTH
      push();
      float noseWidth = headWidth * 0.2;
      float noseHeight = noseWidth;
      float noseTranslateX = halfHeadWidth - (noseWidth / 2);
      float noseTranslateY = halfHeadHeight;
      translate(noseTranslateX, noseTranslateY);

      { // START FACE.NOSE+MOUTH.WHISKERS
        push();
        float whiskersCount = 3;
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
      } // END FACE.NOSE+MOUTH.WHISKERS

      // Draw the nose
      fill(catNoseColor);
      triangle(0, 0, noseWidth, 0, noseWidth / 2, noseHeight);

      { // START FACE.NOSE+MOUTH.MOUTH
        push();
        float mouthTranslateY = noseHeight;
        float mouthHeight = noseWidth * 0.3;

        // Draw the nose and lips connector
        stroke(0);
        translate(noseWidth / 2, mouthTranslateY);
        line(0, 0, 0, mouthHeight);

        // Draw the lips
        float lipWidth = noseWidth * 0.5;
        float lipHeight = noseHeight * 0.25;
        translate(0, mouthHeight);
        line(0, 0, -lipWidth, lipHeight);
        line(0, 0, lipWidth, lipHeight);

        pop();
      } // END FACE.NOSE+MOUTH.MOUTH

      pop();
    } // END FACE.NOSE+MOUTH

    { // START FACE.EARS
      push();
      float earsTranslateY = headHeight * 0.05;
      float earsOffsetX = headHeight * 0.05;

      float earWidth = headWidth * 0.3;
      float earHeight = earWidth;

      fill(catEarColor);

      // Draw left ear
      push();
      translate(earsOffsetX, earsTranslateY);
      triangle(0, 0, earWidth, 0, 0, earHeight);
      pop();

      // Draw right ear
      push();
      translate(headWidth - earWidth - earsOffsetX, earsTranslateY);
      triangle(0, 0, earWidth, 0, earWidth, earHeight);
      pop();

      pop();
    } // END FACE.EARS

    pop();
 } // END FACE
}

void drawBody(float myWidth, float myHeight) {
  push(); // START BODY
  fill(catBodyColor);
  arc(0, 0, myWidth, myHeight * 2, PI, TWO_PI);
  pop(); // END BODY
}

void drawPaw(float myWidth, float myHeight) {
  push(); // START PAW
  fill(catPawColor);
  arc(0, 0, myWidth, myHeight, PI, TWO_PI);
  pop(); // END PAW
}
