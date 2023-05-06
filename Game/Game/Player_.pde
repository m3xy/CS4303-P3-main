int speed = 5;
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
    this.pos.y = map.land[(int)this.pos.x/map.lod][(int)this.pos.z/map.lod].h + 10;
    System.out.println(this.pos.x);

    
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
