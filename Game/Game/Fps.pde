//CAMERA
PVector pos = new PVector(0,0,0);
PVector rPos = new PVector(0,0,0);
float cameraZ = ((height/2.0) / tan(PI*30.0/180.0)); //(Default) Render distance
float sensitivity = 0.001;
View view = View.FPS;
float zoom = 100;

//MAP
int w = 1920, h = 1080; //Width, Height
int minH = 0;  //Minimum terrain height
int maxH = 250;  //Maximum terrain height
int lod = 50;  //Level of detail, (positive) Factor to divide the land into columns and rows (Recommended 50 but can go above/below slightly for more or less detail - values: 1 to 100)
Map map = new Map(w, h, lod, minH, maxH); //Land, terrain of the game world

//PLAYER
Player player = new Player((w/2) + lod, (h/2) + lod);

//FIRE
Fire fire = new Fire(w/2, h/2);

//BULLETS
ArrayList<Bullet> bullets = new ArrayList<>();

void drawFPS() {
  fps.beginDraw();
  
  fps.background(20,20,25); //Dark BG (Dark sky)
  fps.lights();
  
  fps.perspective(PI/3.0, float(width)/float(height), cameraZ/50.0, cameraZ*20.0); //Increase render distance
  player.rPos.x -= sensitivity * (mouseY - height/2);
  player.rPos.y += sensitivity * (mouseX - width/2);
  //player.rPos.x = constrain(player.rPos.x, 0.000001, HALF_PI);
  player.rPos.x = constrain(player.rPos.x, PI + 0.01, TWO_PI);
  switch(view) {
    case FPS:
      //x: left right, y: top bottom, z: in out
      //rPos.x = theta, rPos.y = phi
      fps.camera(player.pos.x, player.pos.y, player.pos.z, 
      player.pos.x + (sin(player.rPos.x) * sin(player.rPos.y)),  //X
      player.pos.y + cos(player.rPos.x),                         //Y
      player.pos.z + (sin(player.rPos.x) * cos(player.rPos.y)),  //Z
      0, -1, 0);
      break;
    case MAP:
      //fps.camera(width/2.0, height + zoom, height/2.0, width/2.0, 0, height/2.0, 0, 0, -1);
      fps.camera(player.pos.x, height + zoom, player.pos.z, player.pos.x, 0, player.pos.z, 0, 0, -1);

      break;
  }
  fire.run();
  player.run();
  for (Iterator<Bullet> iterator = bullets.iterator(); iterator.hasNext(); ) {
    Bullet bullet = iterator.next();
    bullet.run();
    if ((int)bullet.vel.mag() < 1) {
      iterator.remove();
    }
  }
  map.draw();
  fps.endDraw();
  image(fps, 0, 0);
}
