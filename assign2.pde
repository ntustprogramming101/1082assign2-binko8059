PImage bg, life, soil, soldier, cabbage, gameover, groundhogDown_Image, groundhogIdle, groundhogLeft_Image, groundhogRight_Image, restartHovered, restartNormal, startHovered, startNormal, title;

final int grid = 80;
final float grassHeight = 15;
final float lifeGap = 20;
final float lifePosition = 10;
final float lifeSize = 50; 
int lifePoint = 2;
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

int groundhogX = grid*4;
int groundhogY = grid;
final int groundhog_W = 80;
final int groundhog_H = 80;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
int nowTime;

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
  groundhogDown_Image = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft_Image = loadImage("img/groundhogLeft.png");
  groundhogRight_Image = loadImage("img/groundhogRight.png");
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
      if(lifePoint >= 1){
      image(life, lifePosition, lifePosition);}
      if(lifePoint >= 2){
      image(life, lifePosition+lifeSize+lifeGap, lifePosition);}
      if(lifePoint >= 3){
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
      int groundhogUp = groundhogY;
      int groundhogDown = groundhogY+groundhog_H;
      int groundhogLeft = groundhogX;
      int groundhogRight = groundhogX+groundhog_W;
      
      
      if(downPressed){
        image(groundhogDown_Image, groundhogX, groundhogY);
      }
      else if(leftPressed){
        image(groundhogLeft_Image, groundhogX, groundhogY);
      }
      else if(rightPressed){
        image(groundhogRight_Image, groundhogX, groundhogY);
      }else{
        image(groundhogIdle, groundhogX, groundhogY);
      }
      
      if(groundhogLeft <0){ groundhogX = 0;}
      if(groundhogRight > width){ groundhogX = width-groundhog_W;}
      if(groundhogDown > height){ groundhogY = height-groundhog_H;}
      
      
      //Sodlier  
      int soldierUp = soldierY;
      int soldierDown = soldierY+soldier_H;
      int soldierLeft = soldierX;
      int soldierRight = soldierX+soldier_W;

        //soldier walking from left to right repeatedly
        soldierX += soldierSpeed;
        frameRate(15);
        if(soldierX>width){
          soldierX = -soldierSize;
        }
        
        //put a soldier image
        image(soldier,soldierX,soldierY);
        
        
        if(groundhogY == soldierY || groundhogDown >soldierUp && groundhogDown <soldierDown){
            if( groundhogLeft <soldierRight && groundhogLeft >soldierLeft || 
                groundhogRight >soldierLeft && groundhogRight <soldierRight ||
                groundhogUp <soldierDown && groundhogUp >soldierUp ||
                groundhogDown >soldierUp && groundhogDown <soldierDown){
               lifePoint -=1;
               groundhogX = grid*4;
               groundhogY = grid;
            }
         }
        
      
      //Cabbage

        if(cabbageQuantity>0){
          //put a cabbage image
            image(cabbage,cabbageX,cabbageY);
            
          if(groundhogX==cabbageX && groundhogY==cabbageY){
              lifePoint +=1;
              cabbageQuantity -= 1;
              }
             
        }
        
        //lifePoint
        if(lifePoint == 0){
          gameState = GAME_LOSE;
        }
    
    break;
    
    
		// Game Lose
    case GAME_LOSE:
      image(gameover, 0, 0, width, height);
      image(restartNormal, buttonX, buttonY);
    
      //button hover
      if(mouseX >buttonLeft && mouseX <buttonRight && mouseY >buttonUp && mouseY <buttonDown) {      
          image(restartHovered, buttonX, buttonY);
          
          //change the game state
          if(mousePressed == true) { 
            
            //reset the parameter
            lifePoint = 2;
            cabbageQuantity = 1;
            soldierX = -soldierSize;
            soldierY = floor(random(2,6))*grid;
            cabbageX  = floor(random(2,8))*grid;
            cabbageY  = floor(random(2,6))*grid;
            
            gameState = GAME_RUN;
          }                        
       }

    break;
    
  }
  
}


void keyPressed(){

     
  if(key==CODED && gameState == GAME_RUN){
    
    switch(keyCode){          
      
      case DOWN:
        downPressed = true;
        groundhogY += grid;        
        break;
      
      case LEFT:
        leftPressed = true;
        groundhogX -= grid;
        break;
      
      case RIGHT:
        rightPressed = true;
        groundhogX += grid;
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
