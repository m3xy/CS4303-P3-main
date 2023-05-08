void drawLOSE() {
  background(102,0,0); //Blood colour
  write(this.g, "YOU LOSE", width/2, height/2, CENTER, CENTER, 50, color(255));
}

void drawWIN() {
  background(251, 183, 65);  //Fire colour
  write(this.g, "YOU WIN", width/2, height/2, CENTER, CENTER, 50, color(255));
}
