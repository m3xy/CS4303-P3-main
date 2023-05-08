color crosshair;
void drawHUD() {
  hud.beginDraw();
  hud.background(color(102,0,0, map(player.hp, 0, player.maxHP/4, 255, 0)), 200); //Transparent background unless hurt (below quarter hp)
  //CROSSHAIR
  crosshair = lerpColor(color(0,255,0), color(255,0,0), map(player.hp, 0, player.maxHP, 1, 0));
  if(player.blocking) {
    hud.fill(crosshair, 90);
    hud.noStroke();
    hud.circle(width/2, height/2, 30);
  }
  hud.fill(0,0);
  hud.stroke(crosshair);
  hud.strokeWeight(1);
  //hud.arc(width/2, height/2, 12, 12, -HALF_PI, map(player.hp, 0, player.maxHP, 0, TWO_PI)-HALF_PI); //Display bug: Inaccurate with increased strokeWeights
  float angle = map(player.hp, 0, player.maxHP, 0, TWO_PI)-HALF_PI;
  for(int i = 9; i < 16; i++)
    hud.arc(width/2, height/2, i, i, -HALF_PI, angle);
  hud.circle(width/2, height/2, 8);
  hud.circle(width/2, height/2, 16);

  write(hud, (int)frameRate + " fps", 0, 0, LEFT, TOP, 15, color(255));
      
  switch(view) {
    case FPS:
      
      break;
    case MAP:
      break;
  }
  
  hud.endDraw();
  image(hud, 0, 0);
}
