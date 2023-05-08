final class Enemies {
  ArrayList<Enemy> list;
  
  Enemies() {
    list = new ArrayList<>();
  }
  
  void run() {
     if((int)random(60 * 5) == 1) {
       list.add(new Enemy(random(w), random(h), 1));
     }
    for (Iterator<Enemy> iterator = list.iterator(); iterator.hasNext(); ) { 
      Enemy enemy = iterator.next();
      enemy.run();
    }
  }
  
  
}
