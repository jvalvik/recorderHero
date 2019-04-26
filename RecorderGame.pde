PImage img;
Note c;
int speed = 1;
int bpm;

// Variables for spawning bars.
int elapsedTime;
int lastTime;

// Variables for spawning notes.
int elapsedTimeNotes;
int lastTimeNotes;
int melodyArrIndex = 0;

float moveSpeed = 5;

float songSpeed = 1; // Variable that should help scale the speed of bars and notes. 1 = 100% speed, 0.5 = 200%, 2 = 50% speed.

boolean bar1 = false;
boolean bar2 = false;
boolean bar3 = false;
boolean bar4 = false;
boolean bar5 = false;
boolean bar6 = false;
boolean bar7 = false;

int switchNum = 1;
barLine line1;
barLine line2;
barLine line3;
barLine line4;
barLine line5;
barLine line6;
barLine line7;

String[] melody = {
  "C", "C", "G", "G", 
  "A", "A", "G", "PAUSE", 
  "F", "F", "E", "E", 
  "D", "D", "C", "PAUSE", 
  "G", "G", "F", "F", 
  "E", "E", "D", "PAUSE", 
  "G", "G", "F", "F", 
  "E", "E", "D", "PAUSE", 
  "C", "C", "G", "G", 
  "A", "A", "G", "PAUSE", 
  "F", "F", "E", "E", 
  "D", "D", "C", "PAUSE", };


final static ArrayList<Note> notes = new ArrayList();

final static ArrayList<barLine> bars = new ArrayList();


//-----------------------------------------------------------------------------------------------

void setup() {
  frameRate(60);  
  size(1057, 816);
  background(255);
  img = loadImage("recorder3_0.jpg");
  c = new Note(width/2, height/2+8, 255, 0, 0); 
  line1 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line2 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line3 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line4 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line5 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line6 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line7 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
}

//-----------------------------------------------------------------------------------------------

void draw() {
  background(img); 
  fill(155);
  //background(200);

  // These circles are made to help with collision detection of notes.
  ellipse(43, 357, 22, 22);
  ellipse(43, 416, 22, 22);
  ellipse(43, 472, 22, 22);
  ellipse(43, 526, 22, 22);
  ellipse(43, 580, 22, 22);
  ellipse(43, 629, 22, 22);
  ellipse(43, 695, 22, 22);

  //Functions for spawning bar indicators.
  //showBarLines();
  //barTrigger();

  //Functions for spawning notes.
  noteTrigger();
  for (Note n : notes) {
    n.script();
  }
}

//-----------------------------------------------------------------------------------------------
// ----- METHODS -------
//-----------------------------------------------------------------------------------------------

// Function that triggers every bar (2400 milliseconds at 100% speed). 
// Twinkle Twinkle is at 100 BPM. One bar consists of 4 beats. 1 beat = 60.000/BPM (600ms in our case)
// The switch goes increments every bar and controls which bar is being spawned. Goes 1-5, 1-5, 1-5 forever.

void barTrigger() {
  elapsedTime = millis() - lastTime;
  // 
  if (elapsedTime >= 2400 * songSpeed) {
    println("Spawning bar " + switchNum + "BAR TIMING: " + elapsedTime);
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
      switchNum++;
      break;
    case 6:
      line6.resetBar();
      bar6 = true;
      switchNum++;
      break;
    case 7:
      line7.resetBar();
      bar7 = true;
      switchNum = 1;
      break;
    }
  }
}

// Function that displays bar objects (vertical line shapes) from the barLine class. Is dependant on the booleans controlled in barTrigger().
void showBarLines() {
  if (bar1) {
    line1.display();
    line1.move(moveSpeed);
  }
  if (bar2) {
    line2.display();
    line2.move(moveSpeed);
  }
  if (bar3) {
    line3.display();
    line3.move(moveSpeed);
  }
  if (bar4) {
    line4.display();
    line4.move(moveSpeed);
  }
  if (bar5) {
    line5.display();
    line5.move(moveSpeed);
  }
  if (bar6) {
    line6.display();
    line6.move(moveSpeed);
  }
  if (bar7) {
    line7.display();
    line7.move(moveSpeed);
  }
}


// Triggers a note after 2.4 sec, every beat (600 ms). 
void noteTrigger() {
  if (millis() >= 2400 && melodyArrIndex < melody.length) {

    elapsedTimeNotes = millis() - lastTimeNotes;
    // 
    if (elapsedTimeNotes >= 600 * songSpeed) {
      //println("ELAPSED TIME: " + elapsedTime);
      lastTimeNotes = millis();
      switch(melody[melodyArrIndex]) {
      case "C":
        println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex + "--------TIME: " +elapsedTimeNotes);
        C();
        melodyArrIndex++;
        break;
      case "D":
        println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        D();
        melodyArrIndex++;
        break;
      case "E":
        println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        E();
        melodyArrIndex++;
        break;
      case "F":
        println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);  
        F();
        melodyArrIndex++;
        break;
      case "G":
        println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        G();
        melodyArrIndex++;
        break;
      case "A":
        println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        B();
        melodyArrIndex++;
        break;
      case "B":
        println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        A();
        melodyArrIndex++;
        break;
      case "PAUSE":
        println("Spawning " + melody[melodyArrIndex] + ". Nothing on this quater note. From array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        melodyArrIndex++;
        break;
      }
    }
  }
}

void C() {
  notes.add(new Note(1053, 357, 0, 255, 0));
  notes.add(new Note(1053, 416, 0, 255, 0));
  notes.add(new Note(1053, 472, 0, 255, 0));
  notes.add(new Note(1053, 526, 0, 255, 0));
  notes.add(new Note(1053, 580, 0, 255, 0));
  notes.add(new Note(1053, 629, 0, 255, 0));
  notes.add(new Note(1053, 695, 0, 255, 0));
  println("C NOTE ADDED TO ARRAY");
}

void D() {
  notes.add(new Note(1053, 357, 255, 0, 0));
  notes.add(new Note(1053, 416, 255, 0, 0));
  notes.add(new Note(1053, 472, 255, 0, 0));
  notes.add(new Note(1053, 526, 255, 0, 0));
  notes.add(new Note(1053, 580, 255, 0, 0));
  notes.add(new Note(1053, 629, 255, 0, 0));
  println("D NOTE ADDED TO ARRAY");
}

void E() {
  notes.add(new Note(1053, 357, 255, 255, 0));
  notes.add(new Note(1053, 416, 255, 255, 0));
  notes.add(new Note(1053, 472, 255, 255, 0));
  notes.add(new Note(1053, 526, 255, 255, 0));
  notes.add(new Note(1053, 580, 255, 255, 0));
  println("E NOTE ADDED TO ARRAY");
}

void F() {
  notes.add(new Note(1053, 357, 0, 0, 255));
  notes.add(new Note(1053, 416, 0, 0, 255));
  notes.add(new Note(1053, 472, 0, 0, 255));
  notes.add(new Note(1053, 526, 0, 0, 255));
  notes.add(new Note(1053, 629, 0, 0, 255));
  notes.add(new Note(1053, 695, 0, 0, 255));
  println("F NOTE ADDED TO ARRAY");
}

void G() {
  notes.add(new Note(1053, 357, 255, 125, 0));
  notes.add(new Note(1053, 416, 255, 125, 0));
  notes.add(new Note(1053, 472, 255, 125, 0));
  println("F NOTE ADDED TO ARRAY");
}

void A() {
  notes.add(new Note(1053, 357, 0, 255, 255));
  notes.add(new Note(1053, 416, 0, 255, 255));
  println("A NOTE ADDED TO ARRAY");
}

void B() {
  notes.add(new Note(1053, 357, 255, 0, 125));
  println("B NOTE ADDED TO ARRAY");
}
