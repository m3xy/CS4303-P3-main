final class Enemy extends Entity {
  
  Enemy(){
    
  }
  
  void update() {
    super.update();
  }
  
  
  void draw() {
    ghost.setFill(50);
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.scale(size);
    fps.shape(ghost);
  }
}
