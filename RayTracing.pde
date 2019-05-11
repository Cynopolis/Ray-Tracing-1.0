Light light = new Light(width/2, height/2, 2000);
ArrayList<Wall> objects = new ArrayList<Wall>();


void setup(){
  for(int i = 0; i < 20; i++){
    Wall wall = new Wall((int)random(40, 1840), (int)random(40, 960), (int)random(360), (int)random(100, 1000));
    objects.add(wall);
  }
  
 size(1880, 1000);
 noStroke();
 background(0);
}

void draw(){
  background(0);
  /*for(Wall object : objects){
    object.drawWall();
  }*/
  light.castLight(objects);
  light.reset();
  
}
