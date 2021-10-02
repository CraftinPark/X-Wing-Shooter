class Stars {

  float xStar, yStar, zStar;
  //float zStar = random(0, 20);
  float yVary;
  float xSpeedStar;
  float lengthStar, thicknessStar;

  Stars() {
     
    float val = random(0, 1);
    
    if (val < 0.8) {
      zStar = random(0, 3);
    } else if (val < .9) {
      zStar = random(3, 9);
    } else if(val < 0.95) {
      zStar = random(9, 12);
    } else {
      xStar = random(12, 20);
    }
    
    xStar = random(0, width+150);
    yStar = random(-100, height+100);
    
    xSpeedStar = map(zStar, 0, 20, -10, -70);
    lengthStar = map(zStar, 0, 20, 1, 250);
    
    thicknessStar = map(zStar, 0, 20, 0.5, 2.5);
    
  } //end of Stars()
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - move
  void move() {
    if (movingUp)
      yVary = map(zStar, 0, 20, 0, -2);
    else if (movingDown)
      yVary = map(zStar, 0, 20, 0, 2);
    else yVary = 0;
    
    xStar += xSpeedStar;
    yStar = yStar + yVary;
    
    if (xStar < -200) {
      xStar = random(width+50, width+150);
    }
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - display
  void display() {
    strokeWeight(thicknessStar);
    stroke(150);
    
    line(xStar, yStar, xStar+lengthStar, yStar);
  }
}