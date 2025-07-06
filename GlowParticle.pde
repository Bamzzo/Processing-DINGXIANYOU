class GlowParticle {
  PVector pos, vel;
  float lifespan;
  float size;
  color c;

  GlowParticle(PVector origin) {
    pos = origin.copy();
    float angle = random(TWO_PI);
    float speed = random(1.5, 4);
    vel = new PVector(cos(angle), sin(angle)).mult(speed);
    lifespan = 255;
    size = random(4, 10);
    c = color(120, 255, 180, 255); // 爆发性玉屑
  }

  void update() {
    pos.add(vel);
    vel.mult(0.96);
    lifespan -= 2.5;
  }

  void display() {
    noStroke();
    blendMode(ADD);
    fill(c, lifespan);
    ellipse(pos.x, pos.y, size, size);
    blendMode(BLEND);
  }

  boolean isDead() {
    return lifespan <= 0;
  }
}
