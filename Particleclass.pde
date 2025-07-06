class Particle {
  PVector pos;
  PVector vel;
  float alpha;
  float size;

  Particle(PVector start) {
    pos = start.copy();
    vel = PVector.random2D().mult(random(0.3, 0.7));
    alpha = 180; // ✅ 更柔和亮度
    size = random(1.5, 3.0); // ✅ 更小体积
  }

  void update() {
    pos.add(vel);
    vel.mult(0.98);
    alpha -= 1.5; // 减缓衰减，保持残影
  }

  void display() {
    noStroke();
    fill(80, 255, 200, alpha); // 绿白柔光
    ellipse(pos.x, pos.y, size, size * 1.4); // 拉长一点保持方向感
  }

  boolean isDead() {
    return alpha <= 0;
  }
}
