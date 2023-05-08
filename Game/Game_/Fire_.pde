final class Fire extends Entity {
  
  Fire(float x, float z) {
    super();
    this.pos.set(x,0,z);
    this.maxHP = Math.max(
      Math.max(PVector.dist(this.pos, new PVector(0, this.pos.y, 0)), PVector.dist(this.pos, new PVector(w, this.pos.y, 0))),
      Math.max(PVector.dist(this.pos, new PVector(0, this.pos.y, h)), PVector.dist(this.pos, new PVector(w, this.pos.y, h)))
    );
    //this.maxEnergy =  Math.max(Math.max(Math.abs(this.pos.x - w), this.pos.x), Math.max(Math.abs(this.pos.z - h), this.pos.z));
    this.hp = maxHP/4; //Initially 25 percent
    this.size = this.hp/20;
  }
  
  void update() {
    //Collision with land
    this.pos.x = constrain(this.pos.x, 0 + size/2, (map.land.length * map.lod) - map.lod - size/2);
    this.pos.z = constrain(this.pos.z, 0 + size/2, (map.land[0].length * map.lod) - map.lod - size/2);
    
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
    this.pos.y = (((z2-z)/(z2-z1))*f1) + (((z-z1)/(z2-z1))*f2);
    super.update();
    
    //HEAL
    if(PVector.dist(this.pos, player.pos) < this.hp && player.hp < player.maxHP && this.hp > 0)
      player.heal();
    else
      player.hurt();  
      
    //DECAY
    this.hp -= map(this.hp*this.hp, 0, this.maxHP*this.maxHP, 0.5, 1.0); //Quadratic falloff (Game gets more difficult as flame decays faster with size)
    if(this.hp < lod)
      this.hp = 0; //Game over
    this.size = this.hp/20;
  }
  
  void draw() {
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.spotLight(251, 183, 65, 0, (this.hp/tan(QUARTER_PI)), 0, 0, -1, 0, QUARTER_PI, 5);  //LIGHTING
    //MODEL
    //fps.sphere(size);
    fps.scale(this.size/1.5);  //Size of flame larger as hp increases
    if(PVector.dist(player.pos, this.pos) < this.size + player.size && view == View.FPS)
      return;
    fps.noStroke();
    //WOOD
    //fps.fill(164,116,73);
    //fps.box(4,0.4,0.4);
    //fps.box(0.4,0.4,4);
    //fps.rotateY(QUARTER_PI);
    //fps.box(4,0.4,0.4);
    //fps.box(0.4,0.4,4);
    //fps.translate(0, 0.5, 0);
    
    
    //FIRE
    fps.rotateY(random(TWO_PI));
    fps.rotateX(random(TWO_PI));
    fps.rotateZ(random(TWO_PI)); 

    fps.fill(251, 183, 65);
    fps.beginShape(TRIANGLES);
    fps.vertex(1,1,1);
    fps.vertex(1,-1,-1);
    fps.vertex(-1,1,-1);
    fps.vertex(1,-1,-1);
    fps.vertex(-1,1,-1);
    fps.vertex(-1,-1,1);
    fps.vertex(1,1,1);
    fps.vertex(1,-1,-1);
    fps.vertex(-1,-1,1);
    fps.vertex(1,1,1);
    fps.vertex(-1,1,-1);
    fps.vertex(-1,-1,1);
    fps.endShape();
    
    fps.fill(251, 90, 65);
    fps.beginShape(TRIANGLES);
    fps.vertex(-1,-1,-1);
    fps.vertex(-1,1,1);
    fps.vertex(1,-1,1);
    fps.vertex(-1,1,1);
    fps.vertex(1,-1,1);
    fps.vertex(1,1,-1);
    fps.vertex(-1,-1,-1);
    fps.vertex(-1,1,1);
    fps.vertex(1,1,-1);
    fps.vertex(-1,-1,-1);
    fps.vertex(1,-1,1);
    fps.vertex(1,1,-1);
    fps.endShape();
    
    fps.fill(226, 251, 65);
    fps.beginShape(TRIANGLES);
    fps.vertex(1, 0, -1/(float)Math.sqrt(2));
    fps.vertex(-1, 0, -1/(float)Math.sqrt(2));
    fps.vertex(0, 1, 1/(float)Math.sqrt(2));
    fps.vertex(-1, 0, -1/(float)Math.sqrt(2));
    fps.vertex(0, 1, 1/(float)Math.sqrt(2));
    fps.vertex(0, -1, 1/(float)Math.sqrt(2));
    fps.vertex(1, 0, -1/(float)Math.sqrt(2));
    fps.vertex(-1, 0, -1/(float)Math.sqrt(2));
    fps.vertex(0, -1, 1/(float)Math.sqrt(2));
    fps.vertex(1, 0, -1/(float)Math.sqrt(2));
    fps.vertex(0, 1, 1/(float)Math.sqrt(2));
    fps.vertex(0, -1, 1/(float)Math.sqrt(2));
    fps.endShape();
    
    fps.fill(100);
    fps.stroke(0);
  }
  
  void feed(float fuel) {
    if(this.hp < this.maxHP) {
      this.hp += fuel;
    }
    
  }
}
