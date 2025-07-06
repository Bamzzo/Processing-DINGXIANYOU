class Butterfly {
  PVector pos;
  PVector target;
  float wingPhase;
  float wingSpeed;
  Wing[] wings;
  PVector[] wingTips;

  Butterfly() {
    pos = new PVector(width / 2, height / 2);
    target = pos.copy();

    color emerald = color(80, 255, 180, 200);
    color turquoise = color(100, 200, 255, 120);
    color glow = color(255, 255, 255, 80);

    wings = new Wing[4];
    wingTips = new PVector[4];

    wings[0] = new Wing(emerald, glow, 1.0, false, false); // 左上
    wings[1] = new Wing(emerald, glow, 1.0, true, false);  // 右上
    wings[2] = new Wing(turquoise, glow, 1.0, false, true); // 左下
    wings[3] = new Wing(turquoise, glow, 1.0, true, true);  // 右下
  }

  void update() {
    target.set(mouseX, mouseY);
    PVector delta = PVector.sub(target, pos);
    float speed = delta.mag();
    delta.mult(0.08);
    pos.add(delta);

    wingSpeed = map(speed, 0, 30, 0.015, 0.15);
    wingPhase += wingSpeed;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    blendMode(ADD);

    float upperFlap = sin(wingPhase) * PI / 10;
    float lowerFlap = sin(wingPhase + PI / 3) * PI / 14;

    // 偏移布局（更贴近中心）
    PVector[] wingOffsets = {
      new PVector(-30, -10), new PVector(30, -10),
      new PVector(-28, 15), new PVector(28, 15)
    };

    float[] flapAngles = {-upperFlap, upperFlap, -lowerFlap, lowerFlap};

    // 🌟 使用 modelX/modelY 记录翅膀真实末端坐标
    for (int i = 0; i < 4; i++) {
      pushMatrix();
      translate(wingOffsets[i].x, wingOffsets[i].y);
      rotate(flapAngles[i]);
      scale(1.0);
      // 最远点假设在 (60, 0)，与 wing 轮廓吻合
      float wx = modelX(60, 0, 0);
      float wy = modelY(60, 0, 0);
      wingTips[i] = new PVector(wx, wy);
      popMatrix();
    }

    // 显示翅膀
    for (int i = 0; i < 4; i++) {
      wings[i].display(wingOffsets[i].x, wingOffsets[i].y, flapAngles[i]);
    }

    // 躯干更大更亮
    noStroke();
    for (int i = 0; i < 6; i++) {
      fill(140, 255, 220, 60 + i * 10);
      ellipse(0, 8 + i * 6, 11 - i * 0.5, 15);
    }

    // 光头
    fill(180, 255, 230, 250);
    ellipse(0, -18, 13, 13);

    blendMode(BLEND);
    popMatrix();

     
  }

  PVector getPos() {
    return pos.copy();
  }
}
