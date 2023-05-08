void keyPressed() {
  if (key == CODED) {  
    switch (keyCode) {
    }
  } else {
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
      case ' ' :
        player.dash();
        break;
      case TAB :   //Map
        view = View.MAP;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
    }
    
  } else {
    switch (key) {  //Movement
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
      case TAB :    //Map
        view = View.FPS;
        break;
    }
  }

}

void mousePressed() {
  switch(mouseButton) {
    case LEFT :
      player.firing = true;
      break;
    case RIGHT :
      player.blocking = true;
      break;
  }
}

void mouseReleased() {
  switch(mouseButton) {
    case LEFT :
      player.firing = false;
      break;
    case RIGHT :
      player.blocking = false;
      break;
  }
}

//Detects scrolling mouse wheel
void mouseWheel(MouseEvent event) {
  zoom += 20 * event.getCount(); //Used in views to zoom
  zoom = constrain(zoom, -player.size*50, player.size*50);
}
