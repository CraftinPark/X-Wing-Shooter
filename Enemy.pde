//Used for shooting as well vv
int randomCount=1;
float randomStart;

class Enemy {
  float yEnemy = random(100, 1000);
  float xEnemy = 1200;
  float yBounceEnemy = 0;
  float yBounceSmoothEnemy = 0.1;
  int healthEnemy = 100;

  float randomStart;
  int randomCount = 1;
  boolean initializeRandomMovement = true;
  float initialRandomMovementX;
  float initialRandomMovementY;

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - move
  void move() {
    randomCount--;

    if (randomCount <= 0) {
      randomStart = random(0, 1);
      randomCount = int(random(40, 150));  
      initializeRandomMovement = true;
    }

    if (randomStart > 0.4) {
      if (initializeRandomMovement) {
        initialRandomMovementX = random(-4, 5);
        initialRandomMovementY = random(-6, 6);
        initializeRandomMovement = false;
      }
      xEnemy += initialRandomMovementX;

      if (xEnemy < 400)
        xEnemy = 400;
      if (xEnemy > 1800)
        xEnemy = 1800;

      yEnemy += initialRandomMovementY;

      if (yEnemy < 200)
        yEnemy = 200;
      if (yEnemy > 1000)
        yEnemy = 1000;
    } else
      yEnemy += yBounceEnemy;

    yBounceEnemy += yBounceSmoothEnemy;

    if (yBounceEnemy < -1.5) {
      yBounceSmoothEnemy = 0.1;
    }

    if (yBounceEnemy > 1.5) {
      yBounceSmoothEnemy = -0.1;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - display
  void display() {

    noStroke();
    fill(255, 100);

    for (int i = 0; i < 3; i++)
      rect(xEnemy + 50, yEnemy - i*50+50, random(10, 50), 1);

    for (int i = 0; i < 3; i++)
      rect(xEnemy-20, yEnemy - i*50+50, random(10, 50), 1);

    image(enemy, xEnemy, yEnemy);

    fill(0, 150);
    rect(xEnemy-50, yEnemy+70, 100, 10);

    fill(#77f442);
    rect(xEnemy-50, yEnemy+70, healthEnemy, 10);
  }

  boolean hitEnemy;
  boolean hitEnemyOnce = true;
  int delay = 60;

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - collision
  void collision(float tempX, float tempY) {

    if (dist(tempX, tempY+30, xEnemy, yEnemy) < 50 || dist(tempX, tempY - 50, xEnemy, yEnemy) < 50) {
      explosion.play();
      health();
      hitEnemy = true;
    }

    textSize(20);

    if (hitEnemy) {
      delay--;

      fill(#ffdaa8);
      ellipse(xEnemy, yEnemy, delay*2, delay*2);

      if (delay <= 0) {
        hitEnemy = false;
        delay = 30;
        hitEnemyOnce = true;
      }
    } //end of if (hitEnemy)
  }

  EnemyBullet E;
  boolean enemyShooting;
  float xEnemyBullet;
  float yEnemyBullet;
  boolean firstFrame;

  void Enemyshoot() {
    text(int(enemyShooting), xEnemy, yEnemy-100);
    if (randomStart < 0.4) {

      if (firstFrame) {
        E = new EnemyBullet(xEnemy, yEnemy);
        enemiesfire.play();
        firstFrame = false;
        enemyShooting = true;
      }
    }

    if (enemyShooting) {
      E.move();
      E.display();

      xEnemyBullet = E.PositionX();
      yEnemyBullet = E.PositionY();

      if (E.finished())
        enemyShooting = false;
    } else firstFrame = true;
  }
  
  boolean takenHit;
  int preHealth;
  int ifHit(int tempHealth) {
    preHealth = tempHealth;
    text(int(tempHealth), 500, 500);
    
    if (dist(xEnemyBullet, yEnemyBullet, 150, yPosWing) < 50) 
      takenHit = true;
      
    if (takenHit) {
      fill(255,0,0,50);
      rect(0,0, width, height);
      
      preHealth -= 4;
      hit.play();
      
      takenHit = false;
    }
    
    return preHealth;
  }

  float xBullet = xEnemy;
  float yBullet = yEnemy;
  boolean shootOnce = true;

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - shoot


  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - health
  void health() {
    if (hitEnemyOnce)
      healthEnemy -= 25;

    hitEnemyOnce = false;

    if (healthEnemy <= 0)
      destroyed = true;
  }

  boolean destroyed;

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - Destroyed
  boolean Destroyed() {
    return destroyed;
  }
}