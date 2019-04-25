PImage img;
Bullet c;
int speed = 1;
int bpm;
int elapsedTime;
int lastTime;

float moveSpeed = 5;

float songSpeed = 1; // Variable that should help scale the speed of bars and notes. 1 = 100% speed, 0.5 = 200%, 2 = 50% speed.

boolean bar1 = false;
boolean bar2 = false;
boolean bar3 = false;
boolean bar4 = false;
boolean bar5 = false;

int switchNum = 1;
barLine line1;
barLine line2;
barLine line3;
barLine line4;
barLine line5;
barLine line6;

void setup() {
  frameRate(60);  
  size(1057,816);
  background(255);
  img = loadImage("recorder3_0.jpg");
  c = new Bullet(width/2,height/2+8); 
  line1 = new barLine((1014/5)*5,250,(1014/5)*5,750);
  line2 = new barLine((1014/5)*5,250,(1014/5)*5,750);
  line3 = new barLine((1014/5)*5,250,(1014/5)*5,750);
  line4 = new barLine((1014/5)*5,250,(1014/5)*5,750);
  line5 = new barLine((1014/5)*5,250,(1014/5)*5,750);
}

void draw() {
  background(img); 
  fill(155);
  
  // These circles are made to help with collision detection of notes.
  ellipse(43, 357, 20, 20);
  ellipse(43, 416, 20, 20);
  ellipse(43, 472, 20, 20);
  ellipse(43, 526, 20, 20);
  ellipse(43, 580, 20, 20);
  ellipse(43, 629, 20, 20);
  ellipse(43, 695, 20, 20);
  
  //Functions for spawning bar indicators.
  showBarLines();
  barTrigger();
  
  //Functions for spawning notes.
  c.display();
  c.move(speed);
}




// ----- METHODS -------


// Function that triggers every bar (2400 milliseconds at 100% speed). 
// Twinkle Twinkle is at 100 BPM. One bar consists of 4 beats. 1 beat = 60.000/BPM (600ms in our case)
// The switch goes increments every bar and controls which bar is being spawned. Goes 1-5, 1-5, 1-5 forever.

void barTrigger() {
  elapsedTime = millis() - lastTime;
  // 
  if (elapsedTime >= 2400 * songSpeed) {
    println("ELAPSED TIME: " + elapsedTime);
    println("Spawning bar " + switchNum);
    lastTime = millis();
    switch(switchNum) {
      case 1:
          line1.resetBar();
          bar1 = true;
          switchNum++;
          break;
      case 2:
          line2.resetBar();
          bar2 = true;
          switchNum++;
          break;
      case 3:
          line3.resetBar();
          bar3 = true;
          switchNum++;
          break;
      case 4:
          line4.resetBar();
          bar4 = true;
          switchNum++;
          break;
      case 5:
          line5.resetBar();
          bar5 = true;
          switchNum = 1;
          break;
    }
  }
}

// Function that displays bar objects (vertical line shapes) from the barLine class. Is dependant on the booleans controlled in barTrigger().
void showBarLines(){
  if(bar1) {
      line1.display();
      line1.move(moveSpeed);
  }
  if(bar2) {
      line2.display();
      line2.move(moveSpeed);
  }
  if(bar3) {
      line3.display();
      line3.move(moveSpeed);
  }
  if(bar4) {
      line4.display();
      line4.move(moveSpeed);
  }
  if(bar5) {
      line5.display();
      line5.move(moveSpeed);
  }
}
