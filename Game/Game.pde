import java.util.*;

//members
PImage background, heart;
int bgY=0;
Player asteroid;
Enemy rocket;
int gameMode = 0;
int score;
//timer for score
int timer;
//timer for levels
int levelTimer;
int highscore = 0;
int hearts=3;
ScreenManager screenManager;

//list for enemies
ArrayList <Enemy> e = new ArrayList <Enemy> ();

void setup() {
  //start game in full screen mode
  fullScreen();
  //size(800, 1000);
  //load background image, and resize it to fit screen
  background=loadImage("images/background/background.jpg");
  background.resize(width, height);
  //create objects and give them starting locations
  asteroid = new Player(width/2-100, height/2-200);
  rocket = new Enemy(height);
  screenManager = new ScreenManager();
}

void draw() {
  //game starts with game mode 0
  //if game mode is 0 draw startScreen function
  if (gameMode==0) {
    screenManager.startScreen();
    // if player chooses to play, game mode changes to 1 and game screen function is drawn
  } else if (gameMode == 1) {
    screenManager.gameScreen();
    //if player crashes game mode is set to 2, and game over screen is drawn
  } else if (gameMode == 2) {
    screenManager.gameOverScreen();
  }
}

// scrolling background copy same background image at x speed
void scrollingBackground() {
  int x = (frameCount % background.height)*4;
  for (int i = -x; i < height; i += background.height) {
    copy(background, 0, 0, width, background.height, 0, i, width, background.height);
  }
}

void keyPressed() { //movement for arrows and keys
  //if game is in 1 mode only left and right keys are possible
  if (gameMode==1) {
    if (asteroid.x >=0) {
      if (keyCode==LEFT || key =='a' || key =='A' ) {
        asteroid.x -=10;
      }
    }
    if (asteroid.x <= width-100) {
      if (keyCode==RIGHT || key =='d' || key =='D') {
        asteroid.x +=10;
      }
    }
  }
  //if game is in 0 mode any key button will work to call start game function
  if (gameMode==0) {
    screenManager.startGame();
  }
  // if game is in 2 mode, y button will reset the game
  if (gameMode==2) {
    //if less than 1 hearts are available game is reset to gameMode 0
    if (hearts<=1) {
      if (key =='Y' || key =='y' ) {
        screenManager.reset();
      }
      //if player still has lives game goes to gameMode 1 without reseting score and player position
    } else {
      if (key =='Y' || key =='y' ) {
        screenManager.liveReset();
      }
    }
    // n button will close the game
    if (key=='N' || key =='n') {
      exit();
    }
  }
}
