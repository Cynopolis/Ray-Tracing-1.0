public class Wall{
  int xPos;
  int yPos;
  float angle;
  int wallLength;
  int r = (int)random(30, 255);
  int g = (int)random(30, 255);
  int b = (int)random(30, 255);
  
  Wall(int xPos, int yPos, float angle, int wallLength){
    this.xPos = xPos;
    this.yPos = yPos;
    this.angle = angle;
    this.wallLength = wallLength;
  }
  
  void drawWall(){
    stroke(r,g,b);
    line(xPos, yPos, (xPos + cos(radians(angle))*wallLength), (yPos + sin(radians(angle))*wallLength));
    //ellipse((xPos + cos(radians(angle))*wallLength), (yPos + sin(radians(angle))*wallLength), 20, 20);
  }
  
  int[] getPos(){
    int[] pos = {xPos, yPos};
    return pos;
  }
  
  float getAngle(){
    return angle;
  }
  
  int getLength(){
    return wallLength;
  }
}
