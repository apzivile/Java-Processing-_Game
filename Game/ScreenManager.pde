class ScreenManager {

  // game mode 0 screen right when game starts
  void startScreen() {
    //call scrolling background function
    scrollingBackground();
    levelTimer = millis();
    //draw rectangle make it transparent/empty, only borders visible 
    noFill();
    rect(width/2-450, height/2-100, 900, 300);
    stroke(225);
    // create text, set size and fill it with color
    textSize(50);
    fill(255, 0, 0);
    //game name
    text("1997 XF11", width/2-150, height/2-110);
    textSize(30);
    fill(255, 0, 0);
    //game info
    text("You - an alien controlling an asteroid.", width/2-400, height/2);
    text("Your job - to avoid rockets and destroy the Earth.", width/2-400, height/2+50);
    text("Asteroid - 1997 XF11 designation. 1 kilometer in size.", width/2-400, height/2+100);
    text("Speed - 30,000 mph. Distance - 2500 miles.", width/2-400, height/2+150);
    textSize(34);
    text("Press Any Button To Start", width/2-200, height/2+250);
  }

  // game mode 1 screen , when player presses any button to play
  void gameScreen() {
    scrollingBackground();
    //player lives
    heart  = loadImage("images/extra/heart.png");
    image(heart, width-50, 0);
    textSize(45);
    fill(255, 0, 0);
    text(hearts, width-80, 43);  
    //level 1 lasts for 30 seconds
    if (millis()-levelTimer <= 30000) {
      textSize(50);
      fill(255, 0, 0);
      text("Level 1", width/2-100, 50);    
      // add 10 points to score every second player doesnt crash
      if (millis()-timer >=1000) {
        score+=10;
        timer = millis();
      }
      //add new rocket to list every 50 frames
      if (frameCount % 50 == 0) {
        e.add(new Enemy(height));
      }
      //level 2, lasts for 30 seconds
    } else if (millis()-levelTimer <=60000) {
      textSize(50);
      fill(255, 0, 0);
      text("Level 2", width/2-100, 50);    

      if (millis()-timer >=1000) {
        score+=30;
        timer = millis();
      }
      if (frameCount % 35 == 0) {
        e.add(new Enemy(height));
      }
      //level 3, final level lasts as long as player is alive
    } else if (millis()-levelTimer >=60000) {
      textSize(50);
      fill(255, 0, 0);
      text("Level 3", width/2-100, 50);    
      if (millis()-timer >=1000) {
        score+=100;
        timer = millis();
      }
      if (frameCount % 30 == 0) {
        e.add(new Enemy(height));
      }
    }

    //render and move every new rocket
    for (int i=e.size()-1; i>=0; i--) {
      Enemy en = e.get(i);
      en.render();
      //change movement for the 3rd lvl
      if (millis()-levelTimer >=60000) {
        en.complexMovement();
      } else
        en.move();
    }
    //text to show current score
    textSize(34);
    fill(255, 0, 0);
    text("Score:" + score, 50, 50); 
    //if score is bigger than highscore set new highscore
    if (score > highscore) {
      highscore = score;
    }
    asteroid.render(); //render player
    // constantly checks if asteroid meets rocket color and crashes
    if (asteroid.hasCrashed()) {
      asteroid.crash();
    }
  }

  // game mode 2 screen when player asteroid crashes
  void gameOverScreen() {
    scrollingBackground();
    //call explosion animation from Player class
    asteroid.explosion();
    // create transparent box with text inside
    noFill();
    rect(width/2-450, height/2, 900, 300);
    stroke(225);
    textSize(50);
    fill(255, 0, 0);
    textSize(32);
    //if score is not bigger than highscore put out only current highscore
    if (score<highscore) {
      text("Highscore : " + highscore, width/2-200, height/2+100);
    } else {
      //if player beats the highescore show congratulations text and the new highscore
      textSize(40);
      text("Congratulations! You beat the highscore. New highscore : " + highscore, 50, 50);
    }
    //if player still has lives put out different text, show reduced hearts as its still unchanged until program reaches live reset function
    if (hearts>1) {
      text("You still have " + (hearts-1) + " live(s)! Make it count.", width/2-350, height/2+50);
    } else {
      text("Game Over", width/2-130, height/2+50);
    }
    text("Your Score : " +score, width/2-200, height/2+150);
    text("Press Y To Play Again", width/2-200, height/2+200);
    text("Press N To Exit", width/2-200, height/2+250);
  }

  // reset required to play game again after crashing
  void reset() {
    // set game mode to 0 
    gameMode=0;
    // reset score
    score= 0;
    //reset hearts
    hearts=3;
    //reset level timer
    levelTimer = millis();
    // reset players location
    asteroid.x=width/2-100;
    asteroid.y=height/2-200;
    //remove existing rockets from list
    e.clear();
  }

  //if player has more than 1 live call live reset function 
  //if player chooses to continue playing, game jumps to mode 1, hearts are reduced by one, and enemies are cleared
  void liveReset() {
    gameMode=1;
    hearts-=1;
    e.clear();
  }

  // start game function is used to start the game while in game mode 0
  void startGame() {
    gameMode=1;
  }
}
