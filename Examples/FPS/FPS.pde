float rotationAngle = 0;
float elevationAngle = HALF_PI;
import java.awt.Robot;
import java.awt.AWTException;

float sens = 0.1;
float centerX;
float centerY;
float centerZ;
float cameraZ = ((height/2.0) / tan(PI*30.0/180.0)); //Camera-Character distance

Robot robot;

void setup() {
  //size(500,500,P3D);
  fullScreen(P3D);
  try{
  robot = new Robot();
  
  }catch(AWTException e) {
    
  }
}

void draw() {
  perspective(PI/3.0, float(width)/float(height), cameraZ/10.0, cameraZ*100.0);
  background(0);
  noCursor();
  pushMatrix();
  //translate(width/2,height/2,0);
  fill(100, 120, 100);
  rectMode(CENTER);
  //box(100000, 2000, 10000);
  box(10000, 2000, 10000);
  popMatrix();
}

void mouseMoved() {
  
  rotationAngle -= map(mouseX - width/2, 0, width, 0, TWO_PI) * sens;
  elevationAngle += map(mouseY - height/2, 0, height, 0, PI) * sens;
  elevationAngle = constrain(elevationAngle, 0, PI);
  
  centerX = cos(rotationAngle) * sin(elevationAngle);
  centerY = sin(rotationAngle) * sin(elevationAngle);
  centerZ = -cos(elevationAngle);
  camera(0, 0, 0, centerY, centerZ, centerX, 0, 1, 0);
  robot.mouseMove(width/2,height/2); //Move back to center
}
