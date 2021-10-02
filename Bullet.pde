class Bullet {

  float xBullet = 100;
  float yBullet;

  int fireOrient;
  boolean fireUpOnce;
  boolean fireDownOnce;      
  boolean fireMidOnce;

  Bullet(float tempY) {
    yBullet = tempY;
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - move
  void move() {
    xBullet += 60;
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - updateDirection
  void updateDirection(boolean tempUp, boolean tempDown) {
    if (tempUp) 
      fireUpOnce = true;

    else if (tempDown) 
      fireDownOnce = true;
    else
      fireMidOnce = true;
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - display
  void display() {
    strokeWeight(8);
    stroke(#ff0000);

    if (fireUpOnce) {
      line(xBullet-100, yBullet-35, xBullet, yBullet-45);
      line(xBullet-90, yBullet-15, xBullet+10, yBullet-25);
      line(xBullet-100, yBullet+5, xBullet, yBullet-5);
      line(xBullet-90, yBullet+25, xBullet+10, yBullet+15);
      
      yBullet -= 10;
    }

    if (fireDownOnce) {
      line(xBullet-100, yBullet-35, xBullet, yBullet-25);
      line(xBullet-90, yBullet-45, xBullet+10, yBullet-35);
      line(xBullet-100, yBullet+35, xBullet, yBullet+45);
      line(xBullet-90, yBullet+25, xBullet+10, yBullet+35);
      
      yBullet += 10;
    }

    if (fireMidOnce) {
      line(xBullet-100, yBullet-35, xBullet, yBullet-35);
      line(xBullet-90, yBullet-45, xBullet+10, yBullet-45);
      line(xBullet-100, yBullet+35, xBullet, yBullet+35);
      line(xBullet-90, yBullet+25, xBullet+10, yBullet+25);
    }
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - PositionX
  float PositionX() {
    return xBullet;
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - PositionY
  float PositionY() {
    return yBullet;
  }
}