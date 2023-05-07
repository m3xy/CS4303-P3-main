long cooldown = 100; //ms

final class Player extends Entity {
  boolean forward = false, backward = false, left = false, right = false, firing = false;
  long cd = 0;
  int speed = 1;
  
  public Player(int x, int z) {
    super(new PVector(x,0,z), new PVector(0,0,0), 1, 0.5, 10, 100); 
  }
  void update() {
    if(forward)
      this.addForce(new PVector(-speed*sin(this.rPos.y),0,-speed*cos(this.rPos.y)));
    if(backward)
      this.addForce(new PVector(speed*sin(this.rPos.y),0,speed*cos(this.rPos.y)));
    if(left)
      this.addForce(new PVector(speed*sin(this.rPos.y + HALF_PI),0,speed*cos(this.rPos.y + HALF_PI)));
    if(right)
      this.addForce(new PVector(speed*sin(this.rPos.y - HALF_PI),0,speed*cos(this.rPos.y - HALF_PI)));
    super.update();
    
    //Collision with land
    this.pos.x = constrain(this.pos.x, 0 + size/2, (map.land.length * map.lod) - map.lod - size/2);
    this.pos.z = constrain(this.pos.z, 0 + size/2, (map.land[0].length * map.lod) - map.lod - size/2);
    //this.pos.y = map.land[(int)this.pos.x/map.lod][(int)this.pos.z/map.lod].h + 10;
    
    //Bilinear interpolation to find height
    float x = this.pos.x/map.lod;
    float z = this.pos.z/map.lod;
    int x1 = (int)Math.floor(this.pos.x/map.lod);
    int x2 = (int)Math.ceil(this.pos.x/map.lod);
    int z1 = (int)Math.floor(this.pos.z/map.lod);
    int z2 = (int)Math.ceil(this.pos.z/map.lod);
    float f11 = map.land[x1][z1].h;
    float f12 = map.land[x1][z2].h;
    float f21 = map.land[x2][z1].h;
    float f22 = map.land[x2][z2].h;
    float f1 = (((x2-x)/(x2-x1))*f11) + (((x-x1)/(x2-x1))*f21);
    float f2 = (((x2-x)/(x2-x1))*f12) + (((x-x1)/(x2-x1))*f22);
    this.pos.y = (((z2-z)/(z2-z1))*f1) + (((z-z1)/(z2-z1))*f2) + 10;
    
    if(firing && System.currentTimeMillis() - cd >= cooldown) {
      fire();
      cd = System.currentTimeMillis();
    }
      
    
  }
  
  void draw() {
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    //fps.lightFalloff(0.8, 0.0, 0.00005); //Faster falloff
    //fps.pointLight(255, 255, 255, 0, maxH, 0);  //Vision light
    fps.rotateY(this.rPos.y);
    fps.rotateX(this.rPos.x);
    switch(view) {
      case FPS:
        break;
      case MAP:
        fps.box(size);
        break;
    }
  }
  
  void fire() {
    Bullet bullet = new Bullet(this);
    bullets.add(bullet);
    bullet.fire();
    this.energy-=1;
  }
  
  void dash() {
    this.addForce(this.vel.mult(8));
    this.energy-=20;
  }
}
