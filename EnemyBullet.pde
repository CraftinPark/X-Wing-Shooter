class EnemyBullet {

  float xBullet;
  float yBullet;

  EnemyBullet(float tempX, float tempY) {
    xBullet = tempX;
    yBullet = tempY;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - move
  void move() {
    xBullet -= 30;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - display
  void display() {
    fill(#38ff1e);
    strokeWeight(8);
    stroke(255, 100);
    rect(xBullet, yBullet, 100, 30);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - PositionX
  float PositionX() {
    return xBullet;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - PositionY
  float PositionY() {
    return yBullet;
  }
  
  boolean done;

  boolean finished() {
    if (xBullet <= - 60)
      done = true;  
    else done = false;

    return done;
  }
}