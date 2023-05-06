import java.awt.Robot;
import java.awt.AWTException;

//DISPLAY
PGraphics fps, hud; //First Person Shooter, Heads-up display
Robot robot;

//PLAYER
Player player = new Player();

//GAME
State state = State.PLAY;

//SETUP
void setup() {
  fullScreen(P2D, SPAN);                        //Menu
  fps = createGraphics(width, height, P3D);     //First person view
  hud = createGraphics(width, height, JAVA2D);  //Heads-up display
  try{
    robot = new Robot();
  }catch(AWTException e) {
    System.err.println("Error: Setting up robot");
  }
  noCursor();
}

//DRAW
void draw() {
  background(255); //White BG
  
  switch(state) {
    
    case PLAY :
      drawFPS();
      drawHUD();
      break;
  }
}
