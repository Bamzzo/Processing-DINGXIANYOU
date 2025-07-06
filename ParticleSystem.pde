class ParticleSystem {
  ArrayList<Particle> trailParticles;
  ArrayList<GlowParticle> burstParticles;

  ParticleSystem() {
    trailParticles = new ArrayList<Particle>();
    burstParticles = new ArrayList<GlowParticle>();
  }

  void addTrail(PVector pos) {
    for (int i = 0; i < 2; i++) {
      trailParticles.add(new Particle(pos.copy()));
    }
  }

  void burst(PVector origin) {
    for (int i = 0; i < 80; i++) {
      burstParticles.add(new GlowParticle(origin));
    }
  }

  void updateAndDisplay() {
    for (int i = trailParticles.size() - 1; i >= 0; i--) {
      Particle p = trailParticles.get(i);
      p.update();
      p.display();
      if (p.isDead()) {
        trailParticles.remove(i);
      }
    }

    for (int i = burstParticles.size() - 1; i >= 0; i--) {
      GlowParticle gp = burstParticles.get(i);
      gp.update();
      gp.display();
      if (gp.isDead()) {
        burstParticles.remove(i);
      }
    }
  }
}
