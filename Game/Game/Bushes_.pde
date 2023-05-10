final class Bushes {
  ArrayList<Bush> list;
  
  Bushes() {
    list = new ArrayList<>();
  }
  
  void run() {
    if((int)random(60 * 5) == 1 && this.list.size() < 10) {  //Roughly try spawn once every 5 seconds (assumes 60fps), 10 max
      list.add(new Bush(random(w-lod-(player.size*2)), random(h-lod-(player.size*2)), random(player.size, player.size*2)));
    }
    for (Iterator<Bush> iterator = list.iterator(); iterator.hasNext(); ) { 
      Bush bush = iterator.next();
      bush.run();
      if(bush.dead())
        iterator.remove();
    }
  }
}
