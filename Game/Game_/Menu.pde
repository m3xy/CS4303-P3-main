void drawMENU() {
  background(20,20,25);
  write(this.g, "ETERNAL FLAME", width/2, height/2, CENTER, CENTER, 50, color(255));
}

//Writes text
void write(PGraphics ctx, String text, float x, float y, int alignX, int alignY, float size, color colour)  {
  ctx.fill(colour);
  ctx.textSize(size);
  ctx.textAlign(alignX, alignY);
  ctx.text(text, x, y);
}
