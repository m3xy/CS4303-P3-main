final class Enemy extends Entity {
  
  Enemy(float x, float z, float hp){
    super();
    this.pos.set(x,0,z);
    this.hp = hp;
    this.damping = 0.5;
    //super(new PVector(x,0,z), new PVector(PI+QUARTER_PI,random(TWO_PI),0), 1, 0.5, 0.2, hp);
  }
  
  void update() {
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
    
    super.update();
    this.rPos.y = atan2(player.pos.x-this.pos.x, player.pos.z-this.pos.z); //Stares at player
    this.addForce(new PVector(dex*sin(this.rPos.y),0,dex*cos(this.rPos.y))); //Move towards player
  }
  
  
  void draw() {
    ghost.setFill(color(128, map(this.energy, 0, this.maxHP, 0, 255)));
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.rotateY(this.rPos.y - HALF_PI);
    fps.scale(size);
    fps.shape(ghost);
  }
}

void spawnEnemy() {
  
}
