import processing.sound.*;
SinOsc sine;
float amp = 0.5;
int freq;


Button stopbutton;
Button startbutton;

boolean start = true;
boolean stop = false;

int interval = 80;
int lastRecordedTime = 0;

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
int melodyArrIndex;

// Variables for making sound.
int elapsedTimeSound;
int lastTimeSound;
int soundArrIndex;


float moveSpeed = 5;

float songSpeed = 1; // Variable that should help scale the speed of bars and notes. 1 = 100% speed, 0.5 = 200%, 2 = 50% speed.
float soundSpeed = (songSpeed/2)*0.98;

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

// Holes for collision detection
PShape hole1;
PShape hole2;
PShape hole3;
PShape hole4;
PShape hole5;
PShape hole6;
PShape hole7;

boolean h1 = false;
boolean h2 = false;
boolean h3 = false;
boolean h4 = false;
boolean h5 = false;
boolean h6 = false;
boolean h7 = false;

boolean C = false;
boolean D = false;
boolean E = false;
boolean F = false;
boolean G = false;
boolean A = false;
boolean B = false;

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

int[] sound = {
  523, 0, 523, 0, 783, 0, 783, 0, 
  880, 0, 880, 0, 783, 783, 0, 0, 
  698, 0, 698, 0, 659, 0, 659, 0, 
  587, 0, 587, 0, 523, 523, 0, 0, 
  783, 0, 783, 0, 698, 0, 698, 0, 
  659, 0, 659, 0, 587, 587, 0, 0, 
  783, 0, 783, 0, 698, 0, 698, 0, 
  783, 0, 783, 0, 587, 587, 0, 0, 
  523, 0, 523, 0, 783, 0, 783, 0, 
  880, 0, 880, 0, 783, 783, 0, 0, 
  698, 0, 698, 0, 659, 0, 659, 0, 
  587, 0, 587, 0, 523, 523, 0, 0 };


final static ArrayList<Note> notes = new ArrayList();

final static ArrayList<barLine> bars = new ArrayList();

//final static ArrayList<Note> endedNotes = new ArrayList();


//-----------------------------------------------------------------------------------------------

void setup() {
  frameRate(60);  
  size(1057, 816);
  background(255);
  img = loadImage("recorder3_0.jpg");
  sine = new SinOsc(this); 
  line1 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line2 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line3 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line4 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line5 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line6 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);
  line7 = new barLine((1014/5)*5, 250, (1014/5)*5, 750);

  elapsedTimeNotes = 0;
  lastTimeNotes = millis();
  melodyArrIndex = 0;
  elapsedTimeSound = 0;
  lastTimeSound = millis();
  soundArrIndex = 0;


  stopbutton = new Button(460, 100, 100, 100, "Stop", 255, 255, 255);
  startbutton = new Button(760, 100, 100, 100, "Start", 255, 255, 255);
}

//-----------------------------------------------------------------------------------------------

void draw() {
  background(img); 
  fill(155);

  if (stopbutton.isClicked()) {
    stop = true;
    start = false;
    elapsedTimeNotes = 0;
    lastTimeNotes = millis();
    melodyArrIndex = 0;
    elapsedTimeSound = 0;
    lastTimeSound = millis();
    soundArrIndex = 0;
  }

  startbutton.update();
  startbutton.render();
  stopbutton.update();
  stopbutton.render();

  // These circles are made to help with collision detection of notes.
  hole1 = createShape(ELLIPSE, 43, 357, 22, 22);
  hole1.setFill(color(100));
  hole2 = createShape(ELLIPSE, 43, 416, 22, 22);
  hole2.setFill(color(100));
  hole3 = createShape(ELLIPSE, 43, 472, 22, 22);
  hole3.setFill(color(100));
  hole4 = createShape(ELLIPSE, 43, 526, 22, 22);
  hole4.setFill(color(100));
  hole5 = createShape(ELLIPSE, 43, 580, 22, 22);
  hole5.setFill(color(100));
  hole6 = createShape(ELLIPSE, 43, 629, 22, 22);
  hole6.setFill(color(100));
  hole7 = createShape(ELLIPSE, 43, 695, 22, 22);
  hole7.setFill(color(100));
  shape(hole1);      // Draws the holes
  shape(hole2);
  shape(hole3);
  shape(hole4);
  shape(hole5);
  shape(hole6);
  shape(hole7);

  //Functions for spawning bar indicators.
  //showBarLines();
  //barTrigger();

  //Functions for spawning notes.
  println(lastRecordedTime);

  if (startbutton.isClicked()) {
    start = true;
    stop = false;
  }

  if (start == true) {
    noteTrigger();
    //soundTrigger();
    for (Note n : notes) {
      n.script();
      noteCheck();
    }
  }
}

//-----------------------------------------------------------------------------------------------
// ----- METHODS -------
//-----------------------------------------------------------------------------------------------

// Function that triggers every bar (2400 milliseconds at 100% speed). 
// Twinkle Twinkle is at 100 BPM. One bar consists of 4 beats. 1 beat = 60.000/BPM (600ms in our case)
// The switch goes increments every bar and controls which bar is being spawned. Goes 1-5, 1-5, 1-5 forever.

/*
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
 */

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
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex + "--------TIME: " +elapsedTimeNotes);
        C();
        melodyArrIndex++;
        break;
      case "D":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        D();
        melodyArrIndex++;
        break;
      case "E":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        E();
        melodyArrIndex++;
        break;
      case "F":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);  
        F();
        melodyArrIndex++;
        break;
      case "G":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        G();
        melodyArrIndex++;
        break;
      case "A":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        B();
        melodyArrIndex++;
        break;
      case "B":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        A();
        melodyArrIndex++;
        break;
      case "PAUSE":
        //println("Spawning " + melody[melodyArrIndex] + ". Nothing on this quater note. From array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        melodyArrIndex++;
        break;
      }
    }
  }
}

/*
void soundTrigger() {
 if (millis() >= 5800 && soundArrIndex < sound.length) {
 
 elapsedTimeSound = millis() - lastTimeSound;
 // 
 if (elapsedTimeSound >= 600 * soundSpeed) {
 lastTimeSound = millis();
 switch(sound[soundArrIndex]) {
 case 523:
 sine.play(523, amp);
 soundArrIndex++;
 break;
 case 587:
 sine.play(587, amp);
 soundArrIndex++;
 break;
 case 659:
 sine.play(659, amp);
 soundArrIndex++;
 break;
 case 698:
 sine.play(698, amp);
 soundArrIndex++;
 break;
 case 783:
 sine.play(783, amp);
 soundArrIndex++;
 break;
 case 880:
 sine.play(880, amp);
 soundArrIndex++;
 break;
 case 987:
 sine.play(987, amp);
 soundArrIndex++;
 break;
 case 0:
 sine.stop();
 soundArrIndex++;
 break;
 }
 }
 }
 }
 */

void C() {
  notes.add(new Note(1053, 357, 0, 255, 0));
  notes.add(new Note(1053, 416, 0, 255, 0));
  notes.add(new Note(1053, 472, 0, 255, 0));
  notes.add(new Note(1053, 526, 0, 255, 0));
  notes.add(new Note(1053, 580, 0, 255, 0));
  notes.add(new Note(1053, 629, 0, 255, 0));
  notes.add(new Note(1053, 695, 0, 255, 0));
  //println("C NOTE ADDED TO ARRAY");
}

void D() {
  notes.add(new Note(1053, 357, 255, 0, 0));
  notes.add(new Note(1053, 416, 255, 0, 0));
  notes.add(new Note(1053, 472, 255, 0, 0));
  notes.add(new Note(1053, 526, 255, 0, 0));
  notes.add(new Note(1053, 580, 255, 0, 0));
  notes.add(new Note(1053, 629, 255, 0, 0));
  //println("D NOTE ADDED TO ARRAY");
}

void E() {
  notes.add(new Note(1053, 357, 255, 255, 0));
  notes.add(new Note(1053, 416, 255, 255, 0));
  notes.add(new Note(1053, 472, 255, 255, 0));
  notes.add(new Note(1053, 526, 255, 255, 0));
  notes.add(new Note(1053, 580, 255, 255, 0));
  //println("E NOTE ADDED TO ARRAY");
}

void F() {
  notes.add(new Note(1053, 357, 0, 0, 255));
  notes.add(new Note(1053, 416, 0, 0, 255));
  notes.add(new Note(1053, 472, 0, 0, 255));
  notes.add(new Note(1053, 526, 0, 0, 255));
  notes.add(new Note(1053, 629, 0, 0, 255));
  notes.add(new Note(1053, 695, 0, 0, 255));
  //println("F NOTE ADDED TO ARRAY");
}

void G() {
  notes.add(new Note(1053, 357, 255, 125, 0));
  notes.add(new Note(1053, 416, 255, 125, 0));
  notes.add(new Note(1053, 472, 255, 125, 0));
  //println("F NOTE ADDED TO ARRAY");
}

void A() {
  notes.add(new Note(1053, 357, 0, 255, 255));
  notes.add(new Note(1053, 416, 0, 255, 255));
  //println("A NOTE ADDED TO ARRAY");
}

void B() {
  notes.add(new Note(1053, 357, 255, 0, 125));
  //println("B NOTE ADDED TO ARRAY");
}

void noteCheck() {

  if (h1 && h2 && h3 && h4 && h5 && h6 && h7) {
    C = true;
    println("C NOTE COVERED!");
    sine.play(523, amp);
    if (millis()-lastRecordedTime>interval) {
      sine.stop();
      lastRecordedTime = millis();
    }
    h1 = false;
    h2 = false;
    h3 = false;
    h4 = false;
    h5 = false;
    h6 = false;
    h7 = false;
  } else if (h1 && h2 && h3 && h4 && h5 && h6 && !h7) {
    D = true;
    println("D NOTE COVERED!");
    sine.play(587, amp);
    if (millis()-lastRecordedTime>interval) {
      sine.stop();
      lastRecordedTime = millis();
    }
    h1 = false;
    h2 = false;
    h3 = false;
    h4 = false;
    h5 = false;
    h6 = false;
    h7 = false;
  } else if (h1 && h2 && h3 && h4 && h5 && !h6 && !h7) {
    E = true;
    println("E NOTE COVERED!");
    sine.play(659, amp);
    if (millis()-lastRecordedTime>interval) {
      sine.stop();
      lastRecordedTime = millis();
    }
    h1 = false;
    h2 = false;
    h3 = false;
    h4 = false;
    h5 = false;
    h6 = false;
    h7 = false;
  } else if (h1 && h2 && h3 && h4 && !h5 && h6 && h7) {
    F = true;
    println("F NOTE COVERED!");
    sine.play(698, amp);
    if (millis()-lastRecordedTime>interval) {
      sine.stop();
      lastRecordedTime = millis();
    }
    h1 = false;
    h2 = false;
    h3 = false;
    h4 = false;
    h5 = false;
    h6 = false;
    h7 = false;
  } else if (h1 && h2 && h3 && !h4 && !h5 && !h6 && !h7) {
    G = true;
    println("G NOTE COVERED!");
    sine.play(783, amp);
    if (millis()-lastRecordedTime>interval) {
      sine.stop();
      lastRecordedTime = millis();
    }
    h1 = false;
    h2 = false;
    h3 = false;
    h4 = false;
    h5 = false;
    h6 = false;
    h7 = false;
  } else if (h1 && h2 && !h3 && !h4 && !h5 && !h6 && !h7) {
    A = true;
    println("A NOTE COVERED!");
    sine.play(880, amp);
    if (millis()-lastRecordedTime>interval) {
      sine.stop();
      lastRecordedTime = millis();
    }
    h1 = false;
    h2 = false;
    h3 = false;
    h4 = false;
    h5 = false;
    h6 = false;
    h7 = false;
  } else if (h1 && !h2 && !h3 && !h4 && !h5 && !h6 && !h7) {
    B = true;
    println("B NOTE COVERED!");
    sine.play(987, amp);
    if (millis()-lastRecordedTime>interval) {
      sine.stop();
      lastRecordedTime = millis();
    }
    h1 = false;
    h2 = false;
    h3 = false;
    h4 = false;
    h5 = false;
    h6 = false;
    h7 = false;
  } else {
    C = false;
    D = false;
    E = false;
    F = false;
    G = false;
    A = false;
    B = false;
  }
}
