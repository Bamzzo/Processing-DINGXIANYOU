Butterfly butterfly;
 
ParticleSystem particleSystem;

void setup() {
  size(1280, 720, P3D);
  surface.setLocation(200, 100); // ✅ 显式窗口位置
  frameRate(60);
  smooth(8);

   
  butterfly = new Butterfly();
  particleSystem = new ParticleSystem();
}

void draw() {
  background(0);
  // ✅ 提前渲染拖尾粒子（位于蝴蝶后方）
  particleSystem.updateAndDisplay();

  butterfly.update();
  butterfly.display(); // 保证蝴蝶在最上层
}
void mouseMoved() {
// ✅ 粒子在蝴蝶周围形成一个“竖直 + 水平”方向上的稀疏云带
  for (int i = -7; i <= 7; i += 14) {
    for (int j = -14; j <= 14; j+=28) {
      PVector p = butterfly.getPos().copy();
      p.y += i * 5; // 竖直方向更宽
      p.x += j * 4; // 水平方向偏移扩展
      particleSystem.addTrail(p);
    }
  }
}


void mousePressed() {
  if (mouseButton == LEFT) {
    particleSystem.burst(butterfly.getPos());
  }
  if (mouseButton == RIGHT) {
    // 🧨 仙蛊飞升：屏幕中心大爆发
    for (int i = 0; i < 6; i++) {
      particleSystem.burst(new PVector(width / 2 + random(-50, 50), height / 2 + random(-50, 50)));
    }
  }
}
