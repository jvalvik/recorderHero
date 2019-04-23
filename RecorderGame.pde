PImage img;
int wait = 6000;
int time = millis();
int increase;

float speed;
int directionX = -1;
int _x = 1000;
int _y;
int s = 3;

int h0,h1,h2,h3,h4,h5,h6;

void setup() {
  size(1057, 816);
  background(255);
  img = loadImage("recorder3_0.jpg");
  time = millis();

  h0 = height/2-50;
  h1 = height/2+7;
  h2 = height/2+(63*1);
  h3 = height/2+(63*2)-9;
  h4 = height/2+(63*3)-17;
  h5 = height/2+(63*4)-32;
  h6 = height/2+(63*5)-28;
}

void draw() {
  background(img); 

  if (millis() - time >= wait) {
    increase++;
    time = millis();
    println(increase);
    _x = 1050;
  }

  switch(increase) {
  case 0:
    c5();
    break;
  case 1:
    d5();
    break;
  case 2:
    e5();
    break;
  }
}

void move(float tspeed) {
  speed = tspeed;
  _x += speed * directionX;
}

void circle(int longitude) {
    _y = longitude;
    noStroke();
    fill(255, 0, 0);
    circle(_x, _y, 25);
}

void remove() {
}

void c5() {
  move(s);
  circle(h0);
  circle(h1);
  circle(h2);
  circle(h3);
  circle(h4);
  circle(h5);
  circle(h6);
}

void d5() {
  move(s);
  circle(h0);
  circle(h1);
  circle(h2);
  circle(h3);
  circle(h4);
  circle(h5);
}

void e5() {
  move(s);
  circle(h0);
  circle(h1);
  circle(h2);
  circle(h3);
  circle(h4);
}

void f5() {
  move(s);
  circle(h0);
  circle(h1);
  circle(h2);
  circle(h3);
  circle(h5);
  circle(h6);
}

void g5() {
  move(s);
  circle(h0);
  circle(h1);
  circle(h2);
}

void a5() {
  move(s);
  circle(h0);
  circle(h1);
}

void b5() {
  move(s);
  circle(h0);
}

void c6() {
  move(s);
  circle(h1);
}


  
