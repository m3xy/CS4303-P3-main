int speed = 1;
final class Player extends Entity {
  boolean forward = false, backward = false, left = false, right = false;
  public Player() {
    super(); 
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
    this.pos.x = constrain(this.pos.x, 0, (map.land.length * map.lod) - map.lod);
    this.pos.z = constrain(this.pos.z, 0, (map.land[0].length * map.lod) - map.lod);
    //this.pos.y = map.land[(int)this.pos.x/map.lod][(int)this.pos.z/map.lod].h + 10;
    
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
    
  }
  
  void draw() {
    switch(view) {
      case FPS:
        break;
      case MAP:
        fps.translate(this.pos.x, this.pos.y, this.pos.z);
        //fps.rotateX(this.rPos.x);
        //fps.rotateY(this.rPos.y);
        //fps.rotateZ(this.rPos.z);
        fps.box(100);
        break;
    }
  }
}
