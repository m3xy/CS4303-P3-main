void drawHUD() {
  hud.beginDraw();
  hud.background(0,0); //Transparent background
  
  //CROSSHAIR
  hud.fill(0,0);
  hud.stroke(lerpColor(color(0,255,0), color(255,0,0), map(player.energy, 0, 100, 1, 0)));
  hud.strokeWeight(1);
  //hud.arc(width/2, height/2, 12, 12, -HALF_PI, map(player.energy, 0, 100, 0, TWO_PI)-HALF_PI); //Display bug: Inaccurate with increased strokeWeights
  float angle = map(player.energy, 0, 100, 0, TWO_PI)-HALF_PI;
  for(int i = 8; i <= 16; i++)
    hud.arc(width/2, height/2, i, i, -HALF_PI, angle);
  hud.circle(width/2, height/2, 8);
  hud.circle(width/2, height/2, 16);
      
  switch(view) {
    case FPS:
      
      break;
    case MAP:
      break;
  }
  
  hud.endDraw();
  image(hud, 0, 0);
}
