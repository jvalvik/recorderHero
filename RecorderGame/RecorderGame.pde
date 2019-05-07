import processing.serial.*;
import processing.sound.*;
SinOsc sine;
float amp = 1;
int freq;

Button twinkleButton;
Button titanicButton;
Button startGame;
Button stopbutton;
Button startbutton;
Button resetbutton;
Button pointShow;
Button speed25;
Button speed50;
Button speed75;
Button speed100;
Button speedShow;

boolean start = false;
boolean stop = false;
boolean startScreenBool = true;

int noteTrailWidth = 35;
int noteTrailHeight = 15;
int noteTrailRadii = 7;

int lastRecordedTime = 0;

int pointInterval = 100;
int lastPointTime = 0;

PImage startScreen;
PImage img;
PImage results;
PImage resultater;
PImage oneStar;
PImage twoStars;
PImage threeStars;
PImage fourStars;
PImage fiveStars;

int speed = 1;
int bpm;

// Variables for receiving data via Bluetooth
Serial myPort;  // Create object from Serial class
char receivedNote;      // Data received from the serial port
Serial pitchPort;
String frequencyString;
int frequency;

boolean addOnce = false;
int points = 0;
float totalPoints;
float pitchPoints;
float fingeringPoints;

String speedString;

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

String[] melodyTwinkle = {
  "C", "", "", "", "C", "", "", "", "G", "", "", "", "G", "", "", "", 
  "A", "", "", "", "A", "", "", "", "G", "", "", "", "", "", "", "", 
  "F", "", "", "", "F", "", "", "", "E", "", "", "", "E", "", "", "", 
  "D", "", "", "", "D", "", "", "", "C", "", "", "", "", "", "", "", 
  "G", "", "", "", "G", "", "", "", "F", "", "", "", "F", "", "", "", 
  "E", "", "", "", "E", "", "", "", "D", "", "", "", "", "", "", "", 
  "G", "", "", "", "G", "", "", "", "F", "", "", "", "F", "", "", "", 
  "E", "", "", "", "E", "", "", "", "D", "", "", "", "", "", "", "", 
  "C", "", "", "", "C", "", "", "", "G", "", "", "", "G", "", "", "", 
  "A", "", "", "", "A", "", "", "", "G", "", "", "", "", "", "", "", 
  "F", "", "", "", "F", "", "", "", "E", "", "", "", "E", "", "", "", 
  "D", "", "", "", "D", "", "", "", "C", "", "", "", "", "", "", "", 
  "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 
  "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", };

// Trail length in beats (quarternotes)
int[] noteTrailTwinkle = {
  4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 
  4, 0, 0, 0, 4, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, };



String[] melodyTitanic = {
  "F", "", "", "F", "F", "", "F", "", "E", "", "F", "", "", "", "E", "", 
  "E", "", "F", "", "", "", "G", "", "A", "", "", "", "G", "", "", "", 
  "F", "", "", "F", "F", "", "F", "", "E", "", "F", "", "", "", "F", "", 
  "C", "", "", "", "", "", "", "", "", "", "", "", "D", "", "E", "", 
  "F", "", "", "", "", "", "", "", "G", "", "", "", "", "", "C_up", "", 
  "C_up", "", "", "", "A_sharp", "", "A", "", "G", "", "", "", "A", "", "A_sharp", "", 
  "A", "", "", "", "G", "", "F", "", "E", "", "F", "", "", "", "E", "", 
  "D", "", "", "", "", "", "", "", "C", "", "", "", "", "", "", "", 
  "F", "", "", "", "", "", "", "", "G", "", "", "", "", "", "C_up", "", 
  "C_up", "", "", "", "A_sharp", "", "A", "", "G", "", "", "", "A", "", "A_sharp", "", 
  "A", "", "", "", "G", "", "F", "", "E", "", "F", "", "", "", "E", "", 
  "E", "", "F", "", "", "", "G", "", "A", "", "", "", "G", "", "", "", 
  "F", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 
  "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 

};

// Trail length in beats (quarternotes)
int[] noteTrailTitanic = {
  3, 0, 0, 1, 2, 0, 2, 0, 2, 0, 4, 0, 0, 0, 2, 0, 
  2, 0, 4, 0, 0, 0, 2, 0, 4, 0, 0, 0, 4, 0, 0, 0, 
  3, 0, 0, 1, 2, 0, 2, 0, 2, 0, 4, 0, 0, 0, 2, 0, 
  12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 
  8, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 2, 0, 
  4, 0, 0, 0, 2, 0, 2, 0, 4, 0, 0, 0, 2, 0, 2, 0, 
  4, 0, 0, 0, 2, 0, 2, 0, 2, 0, 4, 0, 0, 0, 2, 0, 
  8, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 
  8, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 2, 0, 
  4, 0, 0, 0, 2, 0, 2, 0, 4, 0, 0, 0, 2, 0, 2, 0, 
  4, 0, 0, 0, 2, 0, 2, 0, 2, 0, 4, 0, 0, 0, 2, 0, 
  2, 0, 4, 0, 0, 0, 2, 0, 4, 0, 0, 0, 4, 0, 0, 0, 
  12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
};

String[] melody = melodyTitanic;
int[] noteTrail = noteTrailTitanic;


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

final static ArrayList<noteTrail> noteTrails = new ArrayList();

final static ArrayList<barLine> bars = new ArrayList();



//-----------------------------------------------------------------------------------------------

void setup() {
  frameRate(60);  
  size(1057, 816);
  printArray(Serial.list()); // Prints available COMs
  background(255);
  startScreen = loadImage("startScreen.png");
  img = loadImage("recorder5_0.jpg");
  results = loadImage("results.png");
  resultater = loadImage("resultater.png");
  oneStar = loadImage("oneStar.PNG");
  twoStars = loadImage("twoStars.PNG");
  threeStars = loadImage("threeStars.PNG");
  fourStars = loadImage("fourStars.PNG");
  fiveStars = loadImage("fiveStars.PNG");

  sine = new SinOsc(this);
  rectMode(CORNER);
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

  startGame = new Button(width/2-100, 600, 200, 100, "Start Spil!", 255, 255, 255);
  twinkleButton = new Button(800, 350, 200, 50, "Twinkle", 255, 255, 255);
  titanicButton = new Button(800, 450, 200, 50, "Titanic", 255, 255, 255);
  stopbutton = new Button(600, 0, 100, 100, "Stop", 255, 255, 255);
  startbutton = new Button(700, 0, 100, 100, "Start", 255, 255, 255);
  resetbutton = new Button(width/2-100, height-200, 200, 100, "Spil igen", 255, 255, 255);
  speed25 = new Button(50, 350, 200, 50, "25 % speed", 255, 255, 255);
  speed50 = new Button(50, 450, 200, 50, "50 % speed", 255, 255, 255);
  speed75 = new Button(50, 550, 200, 50, "75 % speed", 255, 255, 255);
  speed100 = new Button(50, 650, 200, 50, "Normal speed", 255, 255, 255);


  //String portName = Serial.list()[1]; // assigns bluetooth COM to portName
  //myPort = new Serial(this, portName, 115200);
  //String portNamePitch = Serial.list()[0];
  //pitchPort = new Serial(this, portNamePitch, 9600);
}

//-----------------------------------------------------------------------------------------------

void draw() {
  if (startScreenBool) {
    startScreen();
  } else if (melodyArrIndex >= 22) {
    resultScreen();
  } else if (!startScreenBool) {
    //println(melodyArrIndex);
    background(img);
    fill(155);

    if (songSpeed == 0.25)
      speedString = "25%";
    else if (songSpeed == 0.50)
      speedString = "50%";
    else if (songSpeed == 0.75)
      speedString = "75%";
    else if (songSpeed == 1)
      speedString = "100%";

    pointShow = new Button(800, 735, 200, 50, "Points: " + str(points), 255, 255, 255);
    speedShow = new Button(400, 735, 400, 50, "Current Speed: " + speedString, 255, 255, 255);

    if (speed25.isClicked()) {
      songSpeed = 0.25;
    } else if (speed50.isClicked()) {
      songSpeed = 0.50;
    } else if (speed75.isClicked()) {
      songSpeed = 0.75;
    } else if (speed100.isClicked()) {
      songSpeed = 1;
    }

    if (stopbutton.isClicked()) {
      stop = true;
      start = false;
      elapsedTimeNotes = 0;
      lastTimeNotes = millis();
      melodyArrIndex = 0;
      elapsedTimeSound = 0;
      lastTimeSound = millis();
      soundArrIndex = 0;
      notes.removeAll(notes);
      noteTrails.removeAll(noteTrails);
      sine.stop();
      points = 0;
    }
    /*stopbutton.render();
     stopbutton.update();
     stopbutton.render();
     startbutton.update();
     startbutton.render();
     speed25.render();
     speed25.update();
     speed50.render();
     speed50.update();
     speed75.render();
     speed75.update();
     speed100.render();
     speed100.update();*/
    pointShow.render();
    pointShow.update();
    pointShow.render();
    speedShow.update();
    speedShow.render();


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

    pitch(frequency);

    //Functions for spawning bar indicators.
    //showBarLines();
    //barTrigger();

    //Functions for spawning notes.
    //println(points);

    if (startbutton.isClicked()) {
      start = true;
      stop = false;
    }

    if (start == true) {
      noteTrigger();
      for (noteTrail n : noteTrails) {
        n.script();
      }
      for (Note n : notes) {
        n.script();
        noteCheck();
      }
    }
  }
}

//-----------------------------------------------------------------------------------------------
// ----- METHODS -------
//-----------------------------------------------------------------------------------------------

// Triggers a note after 2.4 sec, every beat (600 ms).
void noteTrigger() {
  if (millis() >= 2400 && melodyArrIndex < melody.length) {

    elapsedTimeNotes = millis() - lastTimeNotes;
    //
    if (elapsedTimeNotes >= 150 / songSpeed) {
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
        A();
        melodyArrIndex++;
        break;
      case "A_sharp":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        A_sharp();
        melodyArrIndex++;
        break;
      case "B":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        B();
        melodyArrIndex++;
        break;
      case "C_up":
        //println("Spawning " + melody[melodyArrIndex] + " note, from array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        C_up();
        melodyArrIndex++;
        break;
      case "":
        //println("Spawning " + melody[melodyArrIndex] + ". Nothing on this quater note. From array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        melodyArrIndex++;
        break;
      case "END":
        //println("Spawning " + melody[melodyArrIndex] + ". Nothing on this quater note. From array position: " + melodyArrIndex+ "--------TIME: " +elapsedTimeNotes);
        resultScreen();
        break;
      }
    }
  }
}


void C() {
  notes.add(new Note("C", 1053, 300, 0, 255, 0));
  notes.add(new Note(1053, 357, 0, 255, 0));
  notes.add(new Note(1053, 416, 0, 255, 0));
  notes.add(new Note(1053, 472, 0, 255, 0));
  notes.add(new Note(1053, 526, 0, 255, 0));
  notes.add(new Note(1053, 580, 0, 255, 0));
  notes.add(new Note(1053, 629, 0, 255, 0));
  notes.add(new Note(1053, 695, 0, 255, 0));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 349, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 0));
    noteTrails.add(new noteTrail(i, 408, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 0));
    noteTrails.add(new noteTrail(i, 464, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 0));
    noteTrails.add(new noteTrail(i, 518, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 0));
    noteTrails.add(new noteTrail(i, 572, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 0));
    noteTrails.add(new noteTrail(i, 622, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 0));
    noteTrails.add(new noteTrail(i, 688, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 0));
  }
  //println("C NOTE ADDED TO ARRAY");
}

void D() {
  notes.add(new Note("D", 1053, 300, 255, 0, 0));
  notes.add(new Note(1053, 357, 255, 0, 0));
  notes.add(new Note(1053, 416, 255, 0, 0));
  notes.add(new Note(1053, 472, 255, 0, 0));
  notes.add(new Note(1053, 526, 255, 0, 0));
  notes.add(new Note(1053, 580, 255, 0, 0));
  notes.add(new Note(1053, 629, 255, 0, 0));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 349, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 0));
    noteTrails.add(new noteTrail(i, 408, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 0));
    noteTrails.add(new noteTrail(i, 464, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 0));
    noteTrails.add(new noteTrail(i, 518, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 0));
    noteTrails.add(new noteTrail(i, 572, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 0));
    noteTrails.add(new noteTrail(i, 622, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 0));
  }
  //println("D NOTE ADDED TO ARRAY");
}

void E() {
  notes.add(new Note("E", 1053, 300, 0, 0, 0));
  notes.add(new Note(1053, 357, 255, 255, 0));
  notes.add(new Note(1053, 416, 255, 255, 0));
  notes.add(new Note(1053, 472, 255, 255, 0));
  notes.add(new Note(1053, 526, 255, 255, 0));
  notes.add(new Note(1053, 580, 255, 255, 0));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 349, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 255, 0));
    noteTrails.add(new noteTrail(i, 408, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 255, 0));
    noteTrails.add(new noteTrail(i, 464, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 255, 0));
    noteTrails.add(new noteTrail(i, 518, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 255, 0));
    noteTrails.add(new noteTrail(i, 572, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 255, 0));
  }
  //println("E NOTE ADDED TO ARRAY");
}

void F() {
  notes.add(new Note("F", 1053, 300, 0, 0, 255));
  notes.add(new Note(1053, 357, 0, 0, 255));
  notes.add(new Note(1053, 416, 0, 0, 255));
  notes.add(new Note(1053, 472, 0, 0, 255));
  notes.add(new Note(1053, 526, 0, 0, 255));
  notes.add(new Note(1053, 629, 0, 0, 255));
  notes.add(new Note(1053, 695, 0, 0, 255));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 349, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 0, 255));
    noteTrails.add(new noteTrail(i, 408, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 0, 255));
    noteTrails.add(new noteTrail(i, 464, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 0, 255));
    noteTrails.add(new noteTrail(i, 518, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 0, 255));
    noteTrails.add(new noteTrail(i, 622, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 0, 255));
    noteTrails.add(new noteTrail(i, 688, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 0, 255));
  }
  //println("F NOTE ADDED TO ARRAY");
}

void G() {
  notes.add(new Note("G", 1053, 300, 255, 125, 0));
  notes.add(new Note(1053, 357, 255, 125, 0));
  notes.add(new Note(1053, 416, 255, 125, 0));
  notes.add(new Note(1053, 472, 255, 125, 0));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 349, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 125, 0));
    noteTrails.add(new noteTrail(i, 408, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 125, 0));
    noteTrails.add(new noteTrail(i, 464, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 125, 0));
  }
  //println("F NOTE ADDED TO ARRAY");
}

void A() {
  notes.add(new Note("A", 1053, 300, 0, 255, 255));
  notes.add(new Note(1053, 357, 0, 255, 255));
  notes.add(new Note(1053, 416, 0, 255, 255));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 349, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 255));
    noteTrails.add(new noteTrail(i, 408, noteTrailWidth, noteTrailHeight, noteTrailRadii, 0, 255, 255));
  }
  //println("A NOTE ADDED TO ARRAY");
}

void A_sharp() {
  notes.add(new Note("A#", 1053, 300, 255, 0, 125));
  notes.add(new Note(1053, 357, 255, 0, 125));
  notes.add(new Note(1053, 472, 255, 0, 125));
  notes.add(new Note(1053, 526, 255, 0, 125));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 349, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 125));
    noteTrails.add(new noteTrail(i, 464, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 125));
    noteTrails.add(new noteTrail(i, 518, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 125));
  }
}

void B() {
  notes.add(new Note("B", 1053, 300, 255, 0, 125));
  notes.add(new Note(1053, 357, 255, 0, 125));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 349, noteTrailWidth, noteTrailHeight, noteTrailRadii, 255, 0, 125));
  }
  //println("B NOTE ADDED TO ARRAY");
}

void C_up() {
  notes.add(new Note("C", 1053, 300, 125, 255, 0));
  notes.add(new Note(1053, 416, 125, 255, 0));
  for (int i=1053; i<1053+(35*noteTrail[melodyArrIndex]); i+=noteTrailWidth-5) {
    noteTrails.add(new noteTrail(i, 408, noteTrailWidth, noteTrailHeight, noteTrailRadii, 125, 255, 0));
  }
  //println("B NOTE ADDED TO ARRAY");
}


void noteCheck() {

  /*if (myPort.available() > 0) {  // If data is available,
   receivedNote = myPort.readChar();         // read it and store it in val
   //if (receivedNote != 'N')
   //println(receivedNote);
   if (pitchPort.available() > 0) {  // If data is available,
   frequencyString = pitchPort.readString();         // read it and store it in val
   frequency = int(frequencyString);
   println("frequency: " + frequency);
   }*/


  if (h1 && h2 && h3 && h4 && h5 && h6 && h7) {
    C = true;
    sine.play(523, amp);
    falsefy();
  } else if (h1 && h2 && h3 && h4 && h5 && h6 && !h7) {
    D = true;
    sine.play(587, amp);
    falsefy();
  } else if (h1 && h2 && h3 && h4 && h5 && !h6 && !h7) {
    E = true;
    sine.play(659, amp);
    falsefy();
  } else if (h1 && h2 && h3 && h4 && !h5 && h6 && h7) {
    F = true;
    sine.play(698, amp);
    falsefy();
  } else if (h1 && h2 && h3 && !h4 && !h5 && !h6 && !h7) {
    G = true;
    sine.play(783, amp);
    falsefy();
  } else if (h1 && h2 && !h3 && !h4 && !h5 && !h6 && !h7) {
    A = true;
    sine.play(880, amp);
    falsefy();
  } else if (h1 && !h2 && !h3 && !h4 && !h5 && !h6 && !h7) {
    B = true;
    sine.play(987, amp);
    falsefy();
  } else {
    C = false;
    D = false;
    E = false;
    F = false;
    G = false;
    A = false;
    B = false;
    //sineStop();
  }

  if (C && frequency > 515 && frequency < 550) {
    score();
  } else if (D && receivedNote == 'D') {
    score();
  } else if (E && receivedNote == 'E') {
    score();
  } else if (F && receivedNote == 'F') {
    score();
  } else if (G && receivedNote == 'G') {
    score();
  } else if (A && receivedNote == 'A') {
    score();
  } else if (B && receivedNote == 'B') {
    score();
  }
}
//}

void pitch(int freq) {
  
  float average = 0;
  int colour = color(255, 0, 0);
  for (int i = 0; i < 10; i++) {
    average = average + freq;
  }
  
  average = average/10;
  average = average*1.5 - 600;
  
  if (average > (508*1.5)-600 && average < (538*1.5)-600){
    colour = color(0, 255, 0);
  } else if (average > (572*1.5)-600 && average < (602*1.5)-600) {
    colour = color(0, 255, 0);
  } else if (average > (644*1.5)-600 && average < (674*1.5)-600) {
    colour = color(0, 255, 0);
  } else if (average > (683*1.5)-600 && average < (713*1.5)-600) {
    colour = color(0, 255, 0);
  } else if (average > (768*1.5)-600 && average < (798*1.5)-600) {
    colour = color(0, 255, 0);
  } else if (average > (865*1.5)-600 && average < (895*1.5)-600) {
    colour = color(0, 255, 0);
  } else if (average > (972*1.5)-600 && average < (1002*1.5)-600) {
    colour = color(0, 255, 0);
  }

  if (average > 130 && average < 940) {
    fill(colour);
    ellipse(average, 175, 15, 15);
  } else if (average < 130) {
    fill(255,0,0);
    ellipse(130, 175, 15, 15);
  } else if (average > 940) {
    fill(255,0,0);
    ellipse(940, 175, 15, 15);
  }
}



void score() {
  if (millis()-lastPointTime>pointInterval) {
    points++;
    addOnce = false;
  }
  lastPointTime = millis();
}

void sineStop() {
  if (millis()-lastRecordedTime>elapsedTimeNotes) {
    sine.stop();
    lastRecordedTime = millis();
  }
}

void falsefy() {
  h1 = false;
  h2 = false;
  h3 = false;
  h4 = false;
  h5 = false;
  h6 = false;
  h7 = false;
}

void resultScreen() {
  background(resultater);
  textSize(40);
  fill(0);
  if (points >= totalPoints*0.95) { // 95% Correct = 5 stars
    image(fiveStars, width/2-185, 500);
  } else if (points >= totalPoints*0.75) { // 75% Correct = 4 stars
    image(fourStars, width/2-185, 500);
  } else if (points >= totalPoints*0.50) { // 50% Correct = 3 stars
    image(threeStars, width/2-185, 500);
  } else if (points >= totalPoints*0.25) { // 25% Correct = 2 stars
    image(twoStars, width/2-185, 500);
  } else if (points <= totalPoints*0.10) { // 10% Correct = 1 stars
    image(oneStar, width/2-185, 500);
  }
  text("Samlet score: " + points + "/" + int(totalPoints), width/2, 300);
  textSize(25);
  text("Korrekte finger placeringer: " + int(fingeringPoints) + "/" + int(totalPoints), width/2, 400);
  resetbutton.update();
  resetbutton.render();
  if (resetbutton.isClicked()) {
    stop = false;
    start = false;
    startScreenBool = true;
    elapsedTimeNotes = 0;
    lastTimeNotes = millis();
    melodyArrIndex = 0;
    elapsedTimeSound = 0;
    lastTimeSound = millis();
    soundArrIndex = 0;
    notes.removeAll(notes);
    noteTrails.removeAll(noteTrails);
    sine.stop();
    points = 0;
    fingeringPoints = 0;
  }
}

void startScreen() {
  background(startScreen);
  text("Vælg Hastighed:", 150, 300);
  text("Vælg Sang:", 900, 300);
  startGame.update();
  startGame.render();
  speed25.update();
  speed25.render();
  speed50.render();
  speed50.update();
  speed75.render();
  speed75.update();
  speed100.render();
  speed100.update();
  titanicButton.update();
  titanicButton.render();
  twinkleButton.update();
  twinkleButton.render();
  if (startGame.isClicked()) {
    stop = false;
    startScreenBool = false;
    start = true;
    elapsedTimeNotes = 0;
    lastTimeNotes = millis();
    melodyArrIndex = 0;
    elapsedTimeSound = 0;
    lastTimeSound = millis();
    soundArrIndex = 0;
    notes.removeAll(notes);
    noteTrails.removeAll(noteTrails);
    sine.stop();
    points = 0;
    fingeringPoints = 0;
    totalPoints = 0;
    for (int i = 0; i<melody.length; i++) {
      if (melody[i] != "") {
        totalPoints++;
      }
    }
  }
  if (speed25.isClicked()) {
    songSpeed = 0.25;
    speed25.changeColor(200);
    speed50.changeColor(255);
    speed75.changeColor(255);
    speed100.changeColor(255);
  } else if (speed50.isClicked()) {
    songSpeed = 0.50;
    speed25.changeColor(255);
    speed75.changeColor(255);
    speed100.changeColor(255);
    speed50.changeColor(200);
  } else if (speed75.isClicked()) {
    songSpeed = 0.75;
    speed25.changeColor(255);
    speed50.changeColor(255);
    speed100.changeColor(255);
    speed75.changeColor(200);
  } else if (speed100.isClicked()) {
    songSpeed = 1;
    speed25.changeColor(255);
    speed50.changeColor(255);
    speed75.changeColor(255);
    speed100.changeColor(200);
  }
  if (titanicButton.isClicked()) {
    melody = melodyTitanic;
    noteTrail = noteTrailTitanic;
    titanicButton.changeColor(200);
    twinkleButton.changeColor(255);
  } else if (twinkleButton.isClicked()) {
    melody = melodyTwinkle;
    noteTrail = noteTrailTwinkle;
    twinkleButton.changeColor(200);
    titanicButton.changeColor(255);
  }
}
