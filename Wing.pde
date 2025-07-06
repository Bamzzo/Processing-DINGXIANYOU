class Wing {
  PShape shape;
  color fromColor, toColor;
  float scaleFactor;
  boolean isRightWing;
  boolean isLowerWing;

  Wing(color from, color to, float scale, boolean rightSide, boolean lower) {
    fromColor = from;
    toColor = to;
    scaleFactor = scale;
    isRightWing = rightSide;
    isLowerWing = lower;
    createWingShape();
  }

  void createWingShape() {
    shape = createShape();
    shape.beginShape();
    shape.noStroke();
    shape.fill(fromColor);

    if (!isLowerWing) {
      if (!isRightWing) {
        shape.vertex(0, 0);
        shape.bezierVertex(-10, -80, -40, -120, -70, -110);
        shape.bezierVertex(-90, -90, -60, -30, 0, 0);
      } else {
        shape.vertex(0, 0);
        shape.bezierVertex(10, -80, 40, -120, 70, -110);
        shape.bezierVertex(90, -90, 60, -30, 0, 0);
      }
    } else {
      if (!isRightWing) {
        shape.vertex(0, 0);
        shape.bezierVertex(-20, 20, -50, 50, -55, 90);
        shape.bezierVertex(-30, 100, -10, 80, 5, 50);
        shape.bezierVertex(10, 30, 5, 10, 0, 0);
      } else {
        shape.vertex(0, 0);
        shape.bezierVertex(20, 20, 50, 50, 55, 90);
        shape.bezierVertex(30, 100, 10, 80, -5, 50);
        shape.bezierVertex(-10, 30, -5, 10, 0, 0);
      }
    }

    shape.endShape(CLOSE);
  }

  void display(float x, float y, float rotation) {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    scale(scaleFactor);
    // 🎨 更快的颜色变化
    shape.setFill(lerpColor(fromColor, toColor, (sin(frameCount * 0.1) + 1) / 2));
    shape(shape);
    popMatrix();
  }
}
