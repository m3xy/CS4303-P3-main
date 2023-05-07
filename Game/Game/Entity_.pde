abstract class Entity {
  //Linear and Angular -> Static data: Position. Kinematic data: Velocity. Dynamic data: Acceleration.
  PVector pos, vel, acc, rPos, rVel, rAcc;
  
  //Mass and damping factor
  float mass, damping, size, energy;
  
  public Entity() {
    this(new PVector(0,0,0), new PVector(0,0,0), 1, 0, 1, 1);
  }
  
  public Entity(PVector pos, PVector rPos, float mass, float damping, float size, float energy) {
    this.pos = pos;
    this.vel = new PVector(0,0,0);
    this.acc = new PVector(0,0,0);
    this.rPos = rPos;
    this.rVel = new PVector(0,0,0);
    this.rAcc = new PVector(0,0,0);
    this.mass = mass;
    this.damping = damping;
    this.size = size;
    this.energy = energy;
  }
  
  void run() {
    this.update();
    this.display();
  }
  
  void addForce(PVector force) {
    if(mass <= 0f) return; //Infinite mass
    acc.add(force.copy().div(mass));
  }
  
  void addTorque(PVector rotation) {
   if(mass <= 0f) return; //Infinite mass
   rAcc.add(rotation.copy().div(mass));
  }
  
  void update() { //or Integrate
    vel.mult(this.damping); //Apply damping
    rVel.mult(this.damping);
    vel.add(acc); //Update velocity
    rVel.add(rAcc);
    pos.add(vel); //Update position
    rPos.add(rVel);
    acc.mult(0); //Clear acceleration/accumlator
    rAcc.mult(0);
  }
  
  abstract void draw();
  
  void display() {
    fps.pushMatrix();
    this.draw();
    fps.popMatrix();
  }
}
