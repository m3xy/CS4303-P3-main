void drawHUD() {
  hud.beginDraw();
  hud.background(0,0); //Transparent background
  
  switch(view) {
    case FPS:
 
      //CROSSHAIR
      hud.fill(0,0);
      hud.stroke(255);
      hud.strokeWeight(2);
      hud.circle(width/2, height/2, 8);
      
      break;
    case MAP:
      break;
  }
  
  hud.endDraw();
  image(hud, 0, 0);
}
