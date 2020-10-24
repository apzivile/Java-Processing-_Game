// color of enemy for player collision to detect
final color ALIEN1 = color(151, 63, 67);

class Enemy {

  //members
  int x, y;
  int counter=0;
  PImage image1, image2, image3;

  //constuctor
  Enemy( int y) {
    this.y=y;
    for (int i = 0; i < 100; i++) { // make x a random location
      float r = random(0, width);
      x=(int)r;
    }
    image1  = loadImage("images/enemy/rocket1.png");
    image1.resize(100, 100);
    image2  = loadImage("images/enemy/rocket2.png"); 
    image2.resize(100, 100);
    image3  = loadImage("images/enemy/rocket3.png");
    image3.resize(100, 100);
  }
  // render function to draw and animate enemy object
  void render() {
    if (counter>=0 && counter<=20) {
      image(image1, x, y);
    } else if (counter>20 && counter<=40) {
      image(image2, x, y);
    } else if (counter>40 && counter<=60)
    {
      image(image3, x, y);
    } else {
      counter=0; // reset loop
    }
    counter++;
  }
  // enemy movement speed
  void move() {
    y -=5;
  }
  //different movement for lvl 3
  void complexMovement() {
    float r = random(-7, 7); // move randomly
    float speed = random(-7, 0);
    y = y + (int)speed; // y is int, r should be int too
    x= x+ (int)r;
  }
}
