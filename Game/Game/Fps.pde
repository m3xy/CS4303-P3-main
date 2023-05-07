//CAMERA
PVector pos = new PVector(0,0,0);
PVector rPos = new PVector(0,0,0);
float cameraZ = ((height/2.0) / tan(PI*30.0/180.0)); //(Default) Render distance
float sensitivity = 0.001;
View view = View.FPS;
float zoom = 100;

//PLAYER
Player player = new Player(0, 0);

//MAP
int minH = 0;
int maxH = 250;
Map map = new Map(1920, 1080, 50, minH, maxH); //Land, terrain of the game world

//FIRE
Fire fire = new Fire(1920/2, 1080/2);

//BULLETS
ArrayList<Bullet> bullets = new ArrayList<>();

void drawFPS() {
  fps.beginDraw();
  
  fps.background(20); //Dark BG (Darkness)
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
  for(Bullet bullet : bullets) 
    bullet.run();
  map.draw();
  fps.endDraw();
  image(fps, 0, 0);
}
