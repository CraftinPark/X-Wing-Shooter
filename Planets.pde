class Planets {
  float xPlanet = random(width+50, width+1000);
  float yPlanet = random(height);
  float xSpeedPlanet = random(-3, -10);
  
  int typePlanet;

  Planets() {
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - move
  void move() {
    xPlanet += xSpeedPlanet;

    if (xPlanet < -200) {
      xPlanet = random(width+50, width+150);
    }
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// - display
  void display() {
    image(planet, xPlanet, yPlanet);
  }
}