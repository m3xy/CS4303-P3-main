import java.awt.Robot;
import java.awt.AWTException;

//DISPLAY
int w = 1920, h = 1080; //Width, Height
PGraphics fps, hud; //First Person Shooter, Heads-up display
Robot robot;

//GAME
State state = State.PLAY;

//SETUP
void setup() {
  size(1920, 1080);
  w = width;
  h = height;
  fullScreen(P2D, SPAN);                        //Menu
  fps = createGraphics(width, height, P3D);     //First person view
  hud = createGraphics(width, height, JAVA2D);  //Heads-up display
  try{
    robot = new Robot();
  }catch(AWTException e) {
    System.err.println("Error: Setting up robot");
  }
}

//DRAW
void draw() {
  background(255); //White BG
  
  switch(state) {
    case MENU :
      cursor();  //Show cursor
      drawMENU();
      break;
    case PLAY :
      noCursor();  //Hide cursor
      drawFPS();
      drawHUD();
      robot.mouseMove(width/2,height/2); //Move cursor back to center
      break;
  }
}
