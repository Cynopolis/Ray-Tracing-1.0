public class Light{
  int xPos;
  int yPos;
  int pastXPos;
  int pastYPos;
  int lightSize = 20;
  ArrayList<Ray> rays = new ArrayList<Ray>();
  ArrayList<Dot> dots = new ArrayList<Dot>();
  
  Light(int xPos, int yPos, int numberOfRays){
    this.xPos = xPos;
    this.yPos = yPos;
    this.pastXPos = xPos;
    this.pastYPos = yPos;
    this.changeRayNum(numberOfRays);
  }
  
  //draws rays, dots and an ellipse to represent the light source.
  public void castLight(ArrayList<Wall> objects){
    stroke(255);
    this.updatePos();
    for(Ray ray : rays){
      ray.castRay(objects);
      if(ray.getCollissionNumber() > 0 && pastXPos != xPos && pastYPos != yPos){
        createDot(ray.getDot()[0], ray.getDot()[1]);
      }
    }
    drawDots();
    fill(255);
    stroke(255);
    ellipse(xPos, yPos, lightSize, lightSize);
  }
  
  //sets the position of the light source and the origin of all rays to the coordinates of the mouse.
  void updatePos(){
    pastXPos = xPos;
    pastYPos = yPos;
    this.xPos = mouseX;
    this.yPos = mouseY;
    for(Ray ray : rays){
      ray.updatePos(xPos, yPos);
    }
  }
  
  //sets the length of all rays back to 100000.
  void reset(){
    for(Ray ray : rays){
      ray.setLength(100000);
    }
  }
  
  //changes the number of rays the light source casts.
  public void changeRayNum(int numberOfRays){
    float rayStep = (2*PI)/numberOfRays;
    rays.clear();
    float angle = 0.01;
    for(int i = 0; i < numberOfRays; i++){
      Ray ray = new Ray(xPos, yPos, 100000, angle);
      angle = angle + rayStep;
      rays.add(ray);
    }
  }
  
  public int getNumberOfRays(){
    return rays.size();
  }
  
  public void createDot(int x, int y){
    Dot dot = new Dot(x, y);
    dots.add(dot);
    println(dots.size());
    if(dots.size() > 2000){
      for(int i = 0; i < dots.size(); i = i+2){
        dots.remove(i);
      }
    }
  }
  
  public void drawDots(){
    for(Dot dot : dots){
      dot.drawDot();
    }
  }

}



class Ray{
  int xPos;
  int yPos;
  int rayLength;
  float angle;
  ArrayList<Integer> distances = new ArrayList<Integer>();
  
  Ray(int xPos, int yPos, int rayLength, float angle){
    this.xPos = xPos;
    this.yPos = yPos;
    this.rayLength = rayLength;
    this.angle = angle;
  }
  
  //checks for collissions then draws the ray
  void castRay(ArrayList<Wall> objects){
    
    this.collission(objects);
    //line(xPos, yPos, (xPos + cos(angle)*rayLength), (yPos + sin(angle)*rayLength));
  }
  
  void updatePos(int xPos, int yPos){
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  /*checks to see what walls the ray collides with, then 
  finds the one of shortest distance away and sets the ray length equal to that distance.
  */
  void collission(ArrayList<Wall> objects){
    //clears out the arralist that holds the distances to possible object collissions
    distances.clear();
    //sees what objects it collides with
    for(Wall object : objects){
      float theta1 = angle;
      float theta2 = radians(object.getAngle());
      int[] wallPos = object.getPos();
      
      //finds where along the wall the ray collides
      float b = (xPos*sin(theta1) + wallPos[1]*cos(theta1) - yPos*cos(theta1) - wallPos[0]*sin(theta1)) / (cos(theta2)*sin(theta1) - sin(theta2)*cos(theta1));
      
      //if the place along the wall is further away than the wall extends, then it didn't collide
      if(b < object.getLength() && b > 0){
        //finds the length of the ray needed to collide with the wall
        float a = (b*sin(theta2) + wallPos[1]-yPos) / sin(theta1);
        //add that length to a list
        if(a > 0){
          distances.add((int)abs(a));
        }
       
      }
    }
    //finds the shortest distance and sets the length of the ray to that distance
    for(Integer distance : distances){
      if(distance < rayLength){
        rayLength = distance;
      }
    }
    
  }
  
  void setLength(int rayLength){
    this.rayLength = rayLength;
  }
  
  int getRayLength(){
    return this.rayLength;
  }
  
  /*returns the coordinate of the point the ray collides with a wall.
  returns -1, -1 if it doesn't collide with a wall
  */
  public int[] getDot(){
    if(rayLength < 100000){
      int x = (int)(rayLength*cos(angle)+xPos);
      int y = (int)(rayLength*sin(angle)+yPos);
      return new int[]{x, y};
    }
    else{return new int[]{-1,-1};}
  }
  
  int getCollissionNumber(){
    return distances.size();
  }
}



class Dot{
  int xPos;
  int yPos;
  int size = 3;
  int r;
  int g;
  int b;
  
  Dot(int xPos, int yPos){
    this.xPos = xPos;
    this.yPos = yPos;
    r = (int)random(20, 235);
    g = (int)random(20, 235);
    b = (int)random(20, 235);
  }
  
  public void drawDot(){
    fill(r,g,b);
    stroke(r, g, b);
    ellipse(xPos, yPos, size, size);
  }

}
