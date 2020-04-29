final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

int startX = 248;
int startY = 360;
int cabbageY = 0;
int cabbageX = 0;
int floor = 0;
int actionFrame; //groundhog's moving frame 
int groundhogMoveTime = 250;

float groundhogLestX, groundhogLestY;
float lastTime; //time when the groundhog finished moving
float GroundhogX = 320,GroundhogY = 80,robotX,robotY,soldierX=0,soldierY,soldierXspeed,robotRandomX,robotRandomY,soldierRandomX=0,soldierRandomY;
float laserXSpeed,laserX1,laserY,laserX,robotHand;
float cabbageRandomX,cabbageRandomY,Groundhogtab = 80;

boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;
boolean cabbageEaten = false;

final int ONE_BLOCK = 80;
final int RESTART_W = 144;
final int RESTART_H = 60;
final int GROUNDHOG_H = 80; 
final int GABBAGE_H = 80;
final int SOLDIER_H = 80;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24, soil0, soil1, soil2, soil3, soil4, soil5, stone1,stone2;
PImage Groundhog , groundhogLeft , groundhogRight , groundhogDown;
PImage heart , heart1 , heart2;
PImage soldier , robot , cabbage;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
float cameraOffsetLestY = 0;
float cameraOffsetDebugY = 0;
boolean debugMode = false;
boolean moveMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  heart = loadImage("img/life.png");
  heart1 = loadImage("img/life.png");
  heart2 = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  //robot = loadImage("img/robot.png");
  Groundhog = loadImage("img/groundhogIdle.png");
  cabbage = loadImage("img/cabbage.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  //robotX = random(160,640-80);
  //robotRandomY = random(160,480);
  cabbageRandomX = random(0,640-80);
  cabbageRandomY = random(160,480);
  soldierRandomY = random(160,480);
  soldierXspeed = 1;
  laserXSpeed = 2;
  laserX1 = robotX;
  laserX = 0;//amount
  robotHand = 0;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetDebugY);
    }
    /* ------ End of Debug Function ------ */

    if(gameState == GAME_OVER){
      pushMatrix();
      translate(0, cameraOffsetY);
    
    }
    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

    if(moveMode){
      pushMatrix();
      translate(0, cameraOffsetY);
    
    }
		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		image(soil8x24, 0, 160);
    //count 24 floor
    for(int i=0;i<24;i++){
    //first 4 floor
      if(i<4){
        for(int j=0;j<width;j+=80){
          image(stone1,j,j+160);
        }
      }
    //floor5-8
      if(i>4 && i<8){
        for(int j=0;j<width;j+=80){
          for(int k=6*ONE_BLOCK;k<10*ONE_BLOCK;k+=80){
            image(soil1,j,k);
            image(stone1,j,j+160);
          }
        }
      }
    //floor9-12
      if(i>=8 && i<12){
        for(int j=0;j<width;j+=80){
          for(int k=10*ONE_BLOCK;k<14*ONE_BLOCK;k+=80){
            image(soil2,j,k);
            if(k/80%4 == 1 || k/80%4 ==2){
              if(j/80%4 == 1|| j/80%4 == 2){
              image(stone1,j,k);
              }
            }
            if(k/80%4 == 0 || k/80%4 == 3){
              if(j/80%4 == 0|| j/80%4 == 3){
              image(stone1,j,k);
              }
            }            
          }
         }
       }
    //floor12-16 
      if(i>=12 && i<16){
        for(int j=0;j<width;j+=80){
          for(int k=14*ONE_BLOCK;k<18*ONE_BLOCK;k+=80){
            image(soil3,j,k);
            if(k/80%4 == 1 || k/80%4 ==2){
              if(j/80%4 == 1|| j/80%4 == 2){
              image(stone1,j,k);
              }
            }
            if(k/80%4 == 0 || k/80%4 == 3){
              if(j/80%4 == 0|| j/80%4 == 3){
              image(stone1,j,k);
              }
            }            
          }
        }
      }
     //floor 16-20
      if(i>=16 && i<20){
        for(int j=0;j<width;j+=80){
          for(int k=18*ONE_BLOCK;k<22*ONE_BLOCK;k+=80){
            image(soil4,j,k);
            if(k/80%4 == 1 || k/80%4 ==2){
              if(j/80%3 == 1|| j/80%3 == 2){
                image(stone1,j,k);
              if(j/80%3 == 2){
                image(stone2,j,k);
              }
              }
            }
            if(k/80%4 == 3){
              if(j/80%3 == 0|| j/80%3 == 1){
                image(stone1,j,k);
              if(j/80%3 == 1){
                image(stone2,j,k);
              }
             }
            }
            if(k/80%4 == 0){
              if(j/80%3 == 0|| j/80%3 == 2){
                image(stone1,j,k);
              if(j/80%3 == 0){
                image(stone2,j,k);
              }
             }
           }            
          }
        }
      }
      
     //floor20-24
      if(i>=20 && i<24){
        for(int j=0;j<width;j+=80){
          for(int k=22*ONE_BLOCK;k<=26*ONE_BLOCK;k+=80){
            image(soil5,j,k);
            if(k/80%4 ==2 || k/80%4 == 1){
              if(j/80%3 == 0|| j/80%3 == 1){
                image(stone1,j,k);
              if(j/80%3 == 1){
                image(stone2,j,k);
              }
              }
            }
            if(k/80%4 == 3){
              if(j/80%3 == 0|| j/80%3 == 2){
                image(stone1,j,k);
              if(j/80%3 == 0){
                image(stone2,j,k);
              }
             }
            }
            if(k/80%4 == 0){
              if(j/80%3 == 1|| j/80%3 == 2){
                image(stone1,j,k);
              if(j/80%3 == 2){
                image(stone2,j,k);
              }
             }
           }            
          }
        }
      }      
    }

		// Player
      if(GroundhogX < 0){
        GroundhogX = 0;
      }
      if(GroundhogX+GROUNDHOG_H > width){
        GroundhogX = width-GROUNDHOG_H;
      }
      if(GroundhogY < 80){
        GroundhogY = 80;
      }
     
      
      //soldier
      soldierX+=soldierXspeed;
      soldierX=soldierX%(480+240);          
      if(soldierRandomY<241){soldierY=160;}
      else if(soldierRandomY<321){soldierY=240;}
      else if(soldierRandomY<401){soldierY=320;}
      else if(soldierRandomY<481){soldierY=400;}
      image(soldier,soldierX-SOLDIER_H,soldierY);
      
      //cabbage
      if(cabbageEaten==false){
        if(cabbageRandomY<240){cabbageY=160;}
        else if(cabbageRandomY<320){cabbageY=240;}
        else if(cabbageRandomY<400){cabbageY=320;}
        else if(cabbageRandomY<480){cabbageY=400;}
        if(cabbageRandomX<80){cabbageX=0;}
        else if(cabbageRandomX<160){cabbageX=80;}
        else if(cabbageRandomX<240){cabbageX=160;}
        else if(cabbageRandomX<320){cabbageX=240;}
        else if(cabbageRandomX<400){cabbageX=320;}
        else if(cabbageRandomX<480){cabbageX=400;}
        else if(cabbageRandomX<560){cabbageX=480;}
        else if(cabbageRandomX<640){cabbageX=560;}  
        image(cabbage,cabbageX,cabbageY);
        if(GroundhogX+GROUNDHOG_H>cabbageX&&GroundhogX<cabbageX+GABBAGE_H 
        && GroundhogY+GROUNDHOG_H>cabbageY&&GroundhogY<cabbageY+GABBAGE_H){
         cabbageEaten = true;
         playerHealth++;
         break;
        }
       }
       
       //groundhog hit solider
       if(GroundhogX+GROUNDHOG_H>soldierX-SOLDIER_H&&GroundhogX<soldierX
       && GroundhogY+GROUNDHOG_H>soldierY&&GroundhogY<soldierY+SOLDIER_H){
         playerHealth--;
         groundhogLestX = 0;
         groundhogLestY = 0;
         GroundhogX = 320;
         GroundhogY = 80;  
         downPressed = false; 
         leftPressed = false;
         rightPressed = false;
         moveMode = true;
         cameraOffsetY += ONE_BLOCK*floor;
         floor = 0;
       }
       if(playerHealth==0){
         gameState = 2;
       }
    //groundghogidle
     if (downPressed == false && leftPressed == false && rightPressed == false) {
      image(Groundhog, GroundhogX, GroundhogY, GROUNDHOG_H, GROUNDHOG_H);
    }
    //draw the groundhogDown image between 1-14 frames
    if (downPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        GroundhogY += ONE_BLOCK / 15.0;
        if(floor<=20){        
          cameraOffsetY -= ONE_BLOCK / 15.0;
        }
        image(groundhogDown, GroundhogX, GroundhogY, GROUNDHOG_H, GROUNDHOG_H);
      } else {
        GroundhogY = groundhogLestY + ONE_BLOCK;
        if(floor<=20){        
          cameraOffsetY = cameraOffsetLestY - ONE_BLOCK;
        }
        downPressed = false;
      }
    }
    //draw the groundhogLeft image between 1-14 frames
    if (leftPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        GroundhogX -= ONE_BLOCK / 15.0;
        image(groundhogLeft, GroundhogX, GroundhogY, GROUNDHOG_H, GROUNDHOG_H);
      } else {
        GroundhogX = groundhogLestX - ONE_BLOCK;
        leftPressed = false;
      }
    }
    //draw the groundhogRight image between 1-14 frames
    if (rightPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        GroundhogX += ONE_BLOCK / 15.0;
        image(groundhogRight, GroundhogX, GroundhogY, GROUNDHOG_H, GROUNDHOG_H);
      } else {
        GroundhogX = groundhogLestX + ONE_BLOCK;
        rightPressed = false;
      }
    }
    if (moveMode) {
        popMatrix();
    }
		// Health UI
      for(int i = 0 ; i < playerHealth ; i++){
        if(playerHealth >= 5){
          playerHealth = 5;
        }
        image(heart,10 + 70 * i,10);
      }
      
		break;

		case GAME_OVER: // Gameover Screen
    if(floor>20){
      cameraOffsetY += ONE_BLOCK*20;
    }else{
    cameraOffsetY += ONE_BLOCK*floor;
    }
    floor = 0;
    if(gameState == GAME_OVER){
    popMatrix();
  }
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
           playerHealth = 2;
           cabbageEaten = false;
           cabbageRandomX = random(0,640-80);
           cabbageRandomY = random(160,480);
           soldierRandomY = random(160,480);
           soldierX=0;
           groundhogLestX = 0;
           groundhogLestY = 0;
           GroundhogX = 320;
           GroundhogY = 80;
           downPressed = false; 
           leftPressed = false;
           rightPressed = false;
           floor = 0;

			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
 float newTime = millis();
 if (key == CODED) {
    switch (keyCode) {
    case DOWN:
    //make groundhog don't go out of screen
    if(floor<24){
      if (newTime - lastTime > 250) {
        downPressed = true;
        actionFrame = 0;
        groundhogLestY = GroundhogY;
        cameraOffsetLestY = cameraOffsetY;
        lastTime = newTime;
        floor++;
        //println(floor);
     //make camera don't move after 20 floor
        if(floor<=20){
          moveMode = true;
          //cameraOffsetY -= ONE_BLOCK;
        }
      }
    }

      break;
    case LEFT:
      if (newTime - lastTime > 250) {
        leftPressed = true;
        actionFrame = 0;
        groundhogLestX = GroundhogX;
        lastTime = newTime;
      }
      break;
    case RIGHT:
      if (newTime - lastTime > 250) {
        rightPressed = true;
        actionFrame = 0;
        groundhogLestX = GroundhogX;
        lastTime = newTime;
      }
      break;
    }
  }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetDebugY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetDebugY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
