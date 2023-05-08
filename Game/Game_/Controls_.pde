void keyPressed() {
  if(state != State.PLAY) return;
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
  if(state != State.PLAY) return;
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
  switch(state) {
    case MENU:
      state = State.PLAY;
      restart();
      break;
    case PLAY:
      switch(mouseButton) {
        case LEFT :
          player.firing = true;
          break;
        case RIGHT :
          player.blocking = true;
          break;
      }
      break;
    case WIN:
    case LOSE:
      state = State.MENU;
      break;
  }

}

void mouseReleased() {
  if(state != State.PLAY) return;
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
  if(state != State.PLAY) return;
  zoom += 20 * event.getCount(); //Used in views to zoom
  zoom = constrain(zoom, -800, 800);
}
