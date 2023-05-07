final class Bullet extends Entity {
  
  Entity firer;
  
  Bullet(Entity firer) {
    super(firer.pos.copy(), firer.rPos.copy(), 1, 0.95, 3, 50);
    this.firer = firer;
    this.pos.set(this.firer.pos.copy());
  }
  
  void update() {
    super.update();
    
    //Collision detection
    
  }
  
  void draw() {
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.stroke(255);
    fps.sphere(this.size);
    fps.stroke(0);
  }
  
  void fire() {
    this.addForce(new PVector(energy*(sin(this.rPos.x) * sin(this.rPos.y)), energy*cos(this.rPos.x), energy*(sin(this.rPos.x) * cos(this.rPos.y))));
  }
}
