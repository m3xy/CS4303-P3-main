void keyPressed() {
  switch (key) {  //Movement
    case 'w' :
      player.forward = true;
      break;
    case 'a' :
      player.left = true;
      break;
    case 's' :
      player.backward = true;
      break;
    case 'd' :
      player.right = true;
      break;
    case TAB :   //INVENTORY
      view = View.MAP;
      break;
  }
}

void keyReleased() {
  switch (key) {  //Movement
    case TAB :
      view = View.FPS;
      break;
    case 'w' :
      player.forward = false;
      break;
    case 'a' :
      player.left = false;
      break;
    case 's' :
      player.backward = false;
      break;
    case 'd' :
      player.right = false;
      break;
  }
}

void mousePressed() {
  switch(mouseButton) {
    case LEFT :
      //player.fire();
      break;
    case RIGHT :
      //player.dash();
      break;
  }
}

void mouseReleased() {
  switch(mouseButton) {
    case LEFT :
      //player.fire();
      break;
    case RIGHT :
      //player.dash();
      break;
  }
}

//Detects scrolling mouse wheel
void mouseWheel(MouseEvent event) {
  zoom += 20 * event.getCount(); //Used in views to zoom
  zoom = constrain(zoom, -size*50, size*50);
}
