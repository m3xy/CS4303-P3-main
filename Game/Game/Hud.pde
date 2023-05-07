void drawHUD() {
  hud.beginDraw();
  hud.background(0,0); //Transparent background
  
  switch(view) {
    case FPS:
 
      //CROSSHAIR
      hud.fill(0,0);
      hud.stroke(lerpColor(color(0,255,0), color(255,0,0), map(player.energy, 0, 100, 1, 0)));
      hud.strokeWeight(3);
      hud.arc(width/2, height/2, 10, 10, -HALF_PI, map(player.energy, 0, 100, -HALF_PI, 3*HALF_PI));
      //hud.circle(width/2, height/2, 8);
      
      break;
    case MAP:
      break;
  }
  
  hud.endDraw();
  image(hud, 0, 0);
}
