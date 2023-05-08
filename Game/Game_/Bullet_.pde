PVector gravity = new PVector(0,-0.2,0);

final class Bullet extends Entity {
  
  Entity firer;
  
  Bullet(Entity firer) {
    super();
    this.pos.set(firer.pos.copy());
    this.rPos.set(firer.rPos.copy());
    this.damping = 0.99;
    this.size = 3;
    this.energy = lod/2; //Bullet force
    this.firer = firer;
  }
  
  void update() {
    super.update();
    
    //Collision detection
    if(this.pos.x > 0 && this.pos.x < w && this.pos.z > 0 && this.pos.z < h) { //Within map
      for (Iterator<Enemy> iterator = enemies.list.iterator(); iterator.hasNext(); ) { 
        Enemy enemy = iterator.next();
        if(PVector.dist(this.pos, enemy.pos) <= this.size + enemy.size) {  //Hit enemy
          enemy.hp -= 1;  //May change for damage
          this.hp = 0;
        }
      }
      if(PVector.dist(this.pos, fire.pos) <= (this.size) + (fire.size)) {  //Hit fire
        fire.feed((fire.maxHP/2) * (firer.energy/firer.maxHP) * firer.dmg);
        this.hp = 0;
      }
      else if(this.pos.y < map.land[(int)constrain(this.pos.x, 0, w-lod)/lod][(int)constrain(this.pos.z, 0, h-lod)/lod].h) { //Hit ground
        this.hp = 0;
      }
    }
    this.addForce(gravity);  //Apply gravity (for potentially impossible to reach flames)
    
  }
  
  void draw() {
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.noStroke();
    fps.fill(255);
    fps.sphere(this.size);
  }
  
  void fire() {
    this.addForce(new PVector(energy*(sin(this.rPos.x) * sin(this.rPos.y)), energy*cos(this.rPos.x), energy*(sin(this.rPos.x) * cos(this.rPos.y))));
  }
}
