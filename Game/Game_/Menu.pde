boolean help = false; //Show Help
String controls = 
  "W : Forward\n" +
  "A : Left\n" +
  "S : Backward\n" +
  "D : Right\n" +
  "SPACE : Dash\n\n" +
  "LMB : Shoot\n" +
  "RMB : Block\n\n" +
  "TAB : Swap view\n" +
  "SCROLL : Zoom";

String objective = 
  "* Survive\n" +
  "* Kill (shoot) Enemies\n" + 
  "* Fuel (shoot) Fire";

void drawMENU() {
  background(20,20,25);
  write(this.g, "E F I R", width/2, height/2, CENTER, CENTER, 50, color(255));
  write(this.g, "Press Enter", width/2, 2*height/3, CENTER, BOTTOM, 25, color(255));
  drawHelp(this.g);
}

//Writes text
void write(PGraphics ctx, String text, float x, float y, int alignX, int alignY, float size, color colour)  {
  ctx.fill(colour);
  ctx.textSize(size);
  ctx.textAlign(alignX, alignY);
  ctx.text(text, x, y);
}

void drawHelp(PGraphics ctx) {
  if(help) {
    write(ctx, "H - Hide", 0, 0, LEFT, TOP, 17, color(255));
    write(ctx, (int)frameRate + " fps", width, 0, RIGHT, TOP, 15, color(255)); //FPS
    write(ctx, "CONTROLS:", 0.9 * width, 0.05 * height, LEFT, TOP, 20, color(255));
    write(ctx, controls, 0.9 * width, 0.1 * height, LEFT, TOP, 17, color(255));
    write(ctx, "GOAL:", 0.04 * width, 0.05 * height, LEFT, TOP, 20, color(255));
    write(ctx, objective, 0.04 * width, 0.1 * height, LEFT, TOP, 17, color(255));
  } else {
    write(ctx, "H - Help", 0, 0, LEFT, TOP, 17, color(255));
  }
}
