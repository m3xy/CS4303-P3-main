final class Fire extends Entity {
  
  float energy;
  
  Fire(int x, int z) {
    super(x, 0, z);
    energy = 10;

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
    
    this.addTorque(new PVector(0.3*energy,energy,0.3*energy));
  }
  
  void draw() {
    //Lighting
    float brightness = random(255);
    fps.fill(brightness, brightness, random(50, 80));
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    //fps.lightFalloff(0.0, 0.0, map(energy, 0, 100, 0.00005, 0.00000003)); //Slower falloff
    //fps.lightFalloff(map(energy, 0, 100, 1.0, 0.001), 0.0, 0.0); //Slower falloff
    fps.lightFalloff(0.0, map(energy, 0, 100, 0.01, 0.0005), 0.0); //Slower falloff
    fps.pointLight(255, 255, 255, 0, maxH, 0);  //Vision light
    //fps.spotLight(255, 255, 255, 0, maxH, 0, 0, -1, 0, PI, map(energy, 0, 100, 3, 0));  //Flashlight light
    fps.rotateY(this.rPos.y);
    fps.rotateX(this.rPos.x);
    fps.rotateZ(this.rPos.z);
    fps.scale(energy);
    
    
    
    
    fps.beginShape(TRIANGLES);
    fps.stroke(random(255), random(50), random(50));
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
    
    //fps.vertex(-1,-1,-1);
    //fps.vertex(-1,1,1);
    //fps.vertex(1,-1,1);
    //fps.vertex(-1,1,1);
    //fps.vertex(1,-1,1);
    //fps.vertex(1,1,-1);
    //fps.vertex(-1,-1,-1);
    //fps.vertex(-1,1,1);
    //fps.vertex(1,1,-1);
    //fps.vertex(-1,-1,-1);
    //fps.vertex(1,-1,1);
    //fps.vertex(1,1,-1);
    
    //fps.vertex(1, 0, -1/(float)Math.sqrt(2));
    //fps.vertex(-1, 0, -1/(float)Math.sqrt(2));
    //fps.vertex(0, 1, 1/(float)Math.sqrt(2));
    //fps.vertex(-1, 0, -1/(float)Math.sqrt(2));
    //fps.vertex(0, 1, 1/(float)Math.sqrt(2));
    //fps.vertex(0, -1, 1/(float)Math.sqrt(2));
    //fps.vertex(1, 0, -1/(float)Math.sqrt(2));
    //fps.vertex(-1, 0, -1/(float)Math.sqrt(2));
    //fps.vertex(0, -1, 1/(float)Math.sqrt(2));
    //fps.vertex(1, 0, -1/(float)Math.sqrt(2));
    //fps.vertex(0, 1, 1/(float)Math.sqrt(2));
    //fps.vertex(0, -1, 1/(float)Math.sqrt(2));
    
    
    fps.stroke(0,0,0);
    fps.fill(100);
    fps.endShape();
  }
}
