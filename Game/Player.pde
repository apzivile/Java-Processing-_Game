
class Player {

  //members
  int x, y;
  int counter=0;
  PImage image1, image2, image3;
  PImage expImg1, expImg2, expImg3;
  PImage imageR1, imageR2, imageR3;

  //constructor
  Player(int x, int y) {
    this.x=x;
    this.y=y;
    //images will always be the same size
    image1  = loadImage("images/player/ast1.png");
    image1.resize(150, 150);
    image2  = loadImage("images/player/ast2.png"); 
    image2.resize(150, 150);
    image3  = loadImage("images/player/ast3.png");
    image3.resize(150, 150);
  }

  void render() { // animate player
    if (counter<10) {
      image(image1, x, y);
    } else if (counter<20) {
      image(image2, x, y);
    } else if (counter<30) {
      image(image3, x, y);
    } else {
      counter=-1; // reset loop
    }
    counter++;
  }
  // collision function
  boolean crash() {
    for (int i=-75; i<75; i++) {
      //test color in front of player
      color testX = get(x+75+i, y+150);
      //line(x+75+i,y+150);
      //test color on the left player corner
      color testYL = get(x, y+75+i);
      //test color on the right player corner
      color testYR= get(x+150, y+75+i);
      // test color is set to the color that is in x,y location. loop y location and add new values from -10 to 20
      if (testX == ALIEN1 || testYL == ALIEN1 || testYR == ALIEN1) {     // compare if test color is the same as the alien color/ if its the same it means that the alien is at the location of set color(test)
        //e.remove(1);
        //hearts-=1;
        gameMode=2;
        return true;
      }
    }
    return false;
  }

  boolean hasCrashed() {
    crash();
    return true;
  }

  //explosion images and animation
  void explosion() {
    expImg1 = loadImage("images/expl/explS.png"); 
    expImg2 = loadImage("images/expl/explM.png"); 
    expImg3 = loadImage("images/expl/explB.png");

    if (counter<10) {
      image(expImg1, x+75, y+75);
    } else if (counter<20) {
      image(expImg2, x+75, y+75);
    } else if (counter<30) {
      image(expImg3, x+75, y+75);
    } else if (counter<40) {
      image(expImg2, x+75, y+75);
    } else {
      counter=-1; // reset loop
    }
    counter++;
  }
}
