
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void settings() {
  fullScreen();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import processing.sound.*;
PImage xwing, xwingfly, xwingdown, xwingup, planet, enemy;
SoundFile starwars, fire, explosion, flyswitch, enemiesfire, hit;

Stars[] stars = new Stars[1500];
Planets[] planets = new Planets[5];

ArrayList<Enemy> enemies = new ArrayList<Enemy>();

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - setup()

void setup() {
  imageMode(CENTER);

  loadImages();

  loadSounds();

  //Initialize Stars

  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Stars();
  }

  //Initialize Planets

  for (int i = 0; i < planets.length; i++) {
    planets[i] = new Planets();
  }

  //Initialize Enemies

  enemies.add(new Enemy());
}

void loadImages() {

  xwing = loadImage("xwing.png");
  xwing.resize(280, 124);

  xwingfly = loadImage("xwingfly.png");
  xwingfly.resize(280, 124);

  xwingdown = loadImage("xwingdown.png");
  xwingdown.resize(280, 124);

  xwingup = loadImage("xwingup.png");
  xwingup.resize(280, 124);

  enemy = loadImage("enemy.png");
  enemy.resize(141, 127);

  planet = loadImage("planet.png");
  planet.resize(16, 16);
}

void loadSounds() {
  starwars = new SoundFile (this, "starwars.mp3");
  starwars.amp(0.3);
  starwars.play();

  fire = new SoundFile (this, "fire.mp3");
  fire.amp(0.6);

  enemiesfire = new SoundFile (this, "enemyfire.mp3");
  enemiesfire.amp(0.6);

  flyswitch = new SoundFile (this, "flyswitch.mp3");
  flyswitch.amp(1.4);

  explosion = new SoundFile (this, "explosion.mp3");

  hit = new SoundFile (this, "Imhit.mp3");
  hit.amp(10);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// draw()
boolean runGame;

void draw() {
    StartGame();
  
  if (runGame == true) {
    Background();
    Move();
    Display();
    Enemy();
    Shoot();
    SpawnEnemy();
    Time();
    EndGame();
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - Stars, Planets, Background
void Background() {
  background(#000714);

  for (int i = 0; i < planets.length; i++) {
    planets[i].move();
    planets[i].display();
  }

  for (int i = 0; i < stars.length; i++) {
    stars[i].move();
    stars[i].display();
  }
  
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - Movement, Flight bounce
boolean movingUp;
boolean movingDown;

boolean xwingModeFly;

float yPosWing = height/2;
float ySpeedWing;
float yBounceWing = 0;
float yBounceSmooth = 0.1;

void Move() {

  if (keyPressed) {

    //Decide Y speed of X-wing based on keyPressed
    switch(key) {
    case 'w':
      movingUp = true;

      if (xwingModeFly) 
        ySpeedWing = -12;
      else
        ySpeedWing = -3;

      break;

    case 's':
      movingDown = true;

      if (xwingModeFly)
        ySpeedWing = 12;
      else
        ySpeedWing = 3;

      break;
    }
  } //end if keyPressed

  yPosWing += ySpeedWing + yBounceWing;

  //bounce
  if (!movingUp && !movingDown) {

    yBounceWing += yBounceSmooth;

    if (yBounceWing < -2) {
      yBounceSmooth = 0.1;
    }

    if (yBounceWing > 2) {
      yBounceSmooth = -0.1;
    }
  } //end if(!movingUp && !movingDown)
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Images for X-wing
void Display() {

  if (movingDown) {
    pushMatrix();

    translate(150, yPosWing);
    rotate(radians(5));

    if (xwingModeFly)
      image(xwingfly, 0, 0);
    else
      image(xwingdown, 0, 0);

    popMatrix();
  } else if (movingUp) {
    pushMatrix();

    translate(150, yPosWing);
    rotate(radians(-5));

    if (xwingModeFly)
      image(xwingfly, 0, 0);
    else
      image(xwingup, 0, 0);

    popMatrix();
  } else {

    if (xwingModeFly) 
      image(xwingfly, 150, yPosWing);
    else
      image(xwing, 150, yPosWing);
  }

  text("HEALTH", 420, 37);
  fill(0);
  rect(500, 10, 1300, 30);
  fill(#38ff1e);
  strokeWeight(8);
  stroke(255, 100);
  rect(500, 10, health*13, 30);

  fill(255);
  noStroke();
  rect(200, height-30, 1500, 2);
  rect(200+millis()/1000*25, height-50, 20, 20);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - Enemies

int health = 100;

void Enemy() {

  for (int i = 0; i < enemies.size(); i++) {
    Enemy indv = enemies.get(i);

    indv.move();
    indv.display();
    indv.collision(xBullet, yBullet);
    indv.Enemyshoot();

    health = indv.ifHit(health);

    if (indv.Destroyed())
      enemies.remove(i);
  }
}

int delay = 200;

void SpawnEnemy() {
  delay--;
  text(delay, 300, 300);
  if (delay <= 0) {
    delay = 200;  
    if (enemies.size() <= 6) 
      enemies.add(new Enemy());
  }
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - Bullet, Bullet Direction
Bullet B;
boolean firedBullet;
boolean fireFirstFrame;
float fireDelay;
float xBullet;
float yBullet;

void Shoot() {
  if (mousePressed && fireDelay <= 0 && xwingModeFly != true) {

    B = new Bullet(yPosWing+yBounceWing);

    firedBullet = true;
    fireDelay = 30;
    fireFirstFrame = true;

    if (fireFirstFrame) {
      fireFirstFrame = false;
      B.updateDirection(movingUp, movingDown);
      fire.play();
    }
  } //end if mousePressed

  if (firedBullet) {
    B.move();
    B.display();

    xBullet = B.PositionX();
    yBullet = B.PositionY();
  }

  fireDelay--;
}





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - Moving up, Moving down, Fly Mode
void keyReleased() {
  if (key == 'w') {
    movingUp = false;
    ySpeedWing = 0;
  }
  if (key == 's') {
    movingDown = false;
    ySpeedWing = 0;
  }
}

void keyPressed() {
  if (key == ' ' && xwingModeFly) {
    xwingModeFly = false;
    flyswitch.play();
  } else if (key == ' ') { 
    xwingModeFly = true; 
    flyswitch.play();
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - Time
void Time() {
  fill(0, 180);
  noStroke();
  rect(0, 0, 80, 50);
  textSize(30);

  fill(255);
  textAlign(CENTER);
  text(millis()/1000, 40, 40);
}

void EndGame() {

  if (health < 0) {
    starwars.stop();
    runGame = false;
    rect(0, 0, width, height);
    textSize(100);
    fill(0);
    text("GAME OVER", width/2, height/2); 
  }

  if (millis()/1000 >= 60) {
    fill(0);
    starwars.stop();
    runGame = false;
    rect(0, 0, width, height);
    fill(255);
    textSize(100);
    text("YOU WON!", width/2, height/2);
  }
}

void StartGame() {
  fill(0);
  rect(0, 0, width, height);
  fill(255);
  textSize(100);
  textAlign(CENTER);
  text("STAR WARS SHOOTER", width/2, height/2);
  textSize(20);
  text("press any key to begin", width/2, height/2+100);
  if(keyPressed)
    runGame = true;
}
