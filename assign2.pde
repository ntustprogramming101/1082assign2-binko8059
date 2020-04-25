PImage bg, life, soil, soldier, cabbage, gameover, groundhogDown, groundhogIdle, groundhogLeft, groundhogRight, restartHovered, restartNormal, startHovered, startNormal, title;

final int grid = 80;
final float grassHeight = 15;
final float lifeGap = 20;
final float lifePosition = 10;
final float lifeSize = 50; 
int playerHealth = 2;
final float sun = 50;
final float sunDiameter = 120;
final int soldierSize = 80;
final int offsetHeight = 37;
final int offsetWidth = 25;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = 0; 

//init a solier's position randomly
int soldierX = -soldierSize;
int soldierY = floor(random(2,6))*grid;
float soldierSpeed = 3;
final int soldier_H = 80;
final int soldier_W =80;

//init a cabbage's position randomly
int cabbageX  = floor(random(2,8))*grid;
int cabbageY  = floor(random(2,6))*grid;
int cabbageQuantity = 1;
final int cabbage_H = 80;
final int cabbage_W =80;

final int buttonX = 248;
final int buttonY = 360;
final int button_W = 144;
final int button_H = 60;
final int buttonUp = buttonY;
final int buttonDown = buttonY+button_H;
final int buttonLeft = buttonX;
final int buttonRight = buttonX+button_W;

float groundhogX = grid*4;
float groundhogY = grid;
final int groundhog_W = 80;
final int groundhog_H = 80;
      float groundhogUP = groundhogY;
      float groundhogDOWN = groundhogY+groundhog_H;
      float groundhogLEFT = groundhogX;
      float groundhogRIGHT = groundhogX+groundhog_W;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int moveUP = 0;
int moveDOWN = 0;
int moveLEFT = 0;
int moveRIGHT = 0;

void setup() {
	size(640, 480, P2D);
	// Enter Your SetUp Code Here

  //load the images
  bg = loadImage("img/bg.jpg");
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  gameover = loadImage("img/gameover.jpg");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  title = loadImage("img/title.jpg");
 
  imageMode(CORNER);
  frameRate(60);
  
}

void draw() {
  
	// Switch Game State
  switch (gameState){
    
		// Game Start
    case GAME_START: //<>//
      image(title, 0, 0, width, height);
      image(startNormal, buttonX, buttonY);
      
      //button hover
      if(mouseX >buttonLeft && mouseX <buttonRight && mouseY >buttonUp && mouseY <buttonDown) {      
          image(startHovered, buttonX, buttonY);
          
          //change the game state
          if(mousePressed == true) { 
            gameState = GAME_RUN;
          }                        
       }
    break;
    

		// Game Run
    case GAME_RUN:
      
      //put a background image
      image(bg, 0, 0,width, height);
      
      //put three life image 
      if(playerHealth >= 1){
      image(life, lifePosition, lifePosition);}
      if(playerHealth >= 2){
      image(life, lifePosition+lifeSize+lifeGap, lifePosition);}
      if(playerHealth >= 3){
      image(life, lifePosition+lifeSize*2+lifeGap*2, lifePosition);}

      
      //draw the sun
      ellipseMode(CENTER);
      //sun's stroke
      fill(253,184,19);
      strokeWeight(5);
      stroke(255,255,0);
      //sun's body
      ellipse(width-sun,sun,sunDiameter,sunDiameter);
  
      //draw the grass
      noStroke();
      fill(124,204,25);
      rect(0,grid*2-grassHeight,width,grassHeight);
      
      //put the soil image
      image(soil, 0, grid*2);
      
      
      //Groundhog
      //println(groundhogX,groundhogY);
      groundhogUP = groundhogY;
      groundhogDOWN = groundhogY+groundhog_H;
      groundhogLEFT = groundhogX;
      groundhogRIGHT = groundhogX+groundhog_W;
      
      //groundhog movement
      if (moveDOWN>0){
        groundhogY +=80.0/15.0;
      }  else if (moveLEFT>0){
        groundhogX -=80.0/15.0;
      }  else if (moveRIGHT>0){
        groundhogX +=80.0/15.0;
      }
      
      if(moveDOWN > 0) {
        moveDOWN--;}
      if(moveLEFT > 0) {
        moveLEFT--;}
      if(moveRIGHT > 0) {
        moveRIGHT--;}
      
      if(groundhogLEFT <0){groundhogX = 0;}
      if(groundhogRIGHT > width){groundhogX = width-groundhog_W;}
      if(groundhogDOWN > height){ groundhogY = height-groundhog_H;}
      
      if(moveUP==0 && moveDOWN==0 && moveLEFT==0 && moveRIGHT==0){
        image(groundhogIdle , groundhogX , groundhogY);}
      if(moveDOWN > 0){
        image (groundhogDown , groundhogX , groundhogY);}
      if(moveLEFT > 0){
        image (groundhogLeft , groundhogX , groundhogY);}
      if(moveRIGHT > 0){
        image (groundhogRight , groundhogX , groundhogY);}
      
      
      //Sodlier  
      float soldierUP = soldierY;
      float soldierDOWN = soldierY+soldier_H;
      float soldierLEFT = soldierX;
      float soldierRIGHT = soldierX+soldier_W;

        //soldier walking from left to right repeatedly
        soldierX += soldierSpeed;
        if(soldierX>width){
          soldierX = -soldierSize;
        }
        
        //put a soldier image
        image(soldier,soldierX,soldierY);
        
        
        if(groundhogUP < soldierDOWN && groundhogDOWN > soldierUP 
           && groundhogLEFT < soldierRIGHT && groundhogRIGHT > soldierLEFT){
              playerHealth -=1;
              groundhogX = grid*4;
              groundhogY = grid;
              moveDOWN = 0;
              moveLEFT = 0;
              moveRIGHT = 0;
         }
        
      
      //Cabbage
      float cabbageUP = cabbageY;
      float cabbageDOWN = cabbageY+cabbage_H;
      float cabbageLEFT = cabbageX;
      float cabbageRIGHT = cabbageX+cabbage_W;
      
        if(cabbageQuantity>0){
          //put a cabbage image
            image(cabbage,cabbageX,cabbageY);
            
             if(groundhogUP < cabbageDOWN && groundhogDOWN > cabbageUP && 
                groundhogLEFT < cabbageRIGHT && groundhogRIGHT > cabbageLEFT){ 
              playerHealth +=1;
              cabbageQuantity -= 1;
              }  
        }
        
        //playerHealth
        if(playerHealth == 0){
          gameState = GAME_LOSE;
          
          println(groundhogX,groundhogY);
          println(moveDOWN,moveLEFT,moveRIGHT);
        }
    
    break;
    
    
		// Game Lose
    case GAME_LOSE:
      image(gameover, 0, 0, width, height);
    
      //button hover
      if(mouseX >buttonLeft && mouseX <buttonRight && mouseY >buttonUp && mouseY <buttonDown) {      
          image(restartHovered, buttonX, buttonY);
          
          //change the game state
          if(mousePressed == true) { 
            
            //reset the parameter
            playerHealth = 2;
            cabbageQuantity = 1;
            soldierX = -soldierSize;
            soldierY = floor(random(2,6))*grid;
            cabbageX = floor(random(2,8))*grid;
            cabbageY = floor(random(2,6))*grid;
            moveDOWN = 0;
            moveLEFT = 0;
            moveRIGHT = 0;
            
            gameState = GAME_RUN;
            mousePressed = false;
          }                        
       }else {
               image(restartNormal, buttonX, buttonY);
       }

    break;
    
  }
  
}


void keyPressed(){

     
  if(key == CODED && gameState == GAME_RUN && moveDOWN==0 && moveLEFT==0 && moveRIGHT==0){
    
    switch(keyCode){          
      
        case DOWN:
          downPressed = true;
          if(groundhogY < height-groundhog_H-1){ moveDOWN = 15;}
          break;
          
        case LEFT :
          leftPressed = true;
          if(groundhogX>0+1){ moveLEFT = 15;}
          break;
          
        case RIGHT:
          rightPressed = true;
          if(groundhogX < width-groundhog_W-1){ moveRIGHT = 15;}
          break;   
      
    }   
  }  
  
}
////////
void keyReleased(){
   if(key==CODED){    
    switch(keyCode){
      
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }      
  }   
  
}
