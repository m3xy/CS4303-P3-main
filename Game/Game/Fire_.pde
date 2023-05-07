final class Fire extends Entity {
  float decay;
  Fire(int x, int z) {
    super(new PVector(x,0,z), new PVector(0,0,0), 1, 0, 1, Math.max(w, h));
    this.size = this.energy/25;
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
    this.pos.y = (((z2-z)/(z2-z1))*f1) + (((z-z1)/(z2-z1))*f2);
    super.update();
    
    
    //HEAL
    if(PVector.dist(this.pos, player.pos) < this.energy && player.energy < 100 && this.energy > 0)
      player.energy += 0.1;
    else
      player.energy -= 0.1;  
      
    //DECAY
    this.energy *= map(this.energy, 0, Math.max(w,h), 0.9998, 0.999);
    if(this.energy <= lod)
      this.energy = 0;
    this.size = this.energy/25;
  }
  
  void draw() {
    
    fps.noStroke();
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.spotLight(251, 183, 65, 0, (energy/tan(QUARTER_PI)), 0, 0, -1, 0, QUARTER_PI, 1);  //LIGHTING
    
    //MODEL
    fps.scale(this.size);  //Size of flame larger as energy increases
    
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
}
