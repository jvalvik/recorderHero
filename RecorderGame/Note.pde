class Note
{
  int _x;
  int _y;
  int _freq;
  float _amp;
  int r = 25;  //radius
  int _red;
  int _green;
  int _blue;
  float speed = 5;
  float directionX = -1;

  Note(int x, int y, int red, int green, int blue) {
    _x = x;
    _y = y;
    _red = red;
    _green = green;
    _blue = blue;
  }  

  void display() {
    if (_x > 43) {
      noStroke();
      fill(_red, _green, _blue);
      ellipse(_x, _y, r, r);
    }
  }

  void move(float tspeed) {
    speed = tspeed;
    _x += speed * directionX;
  }

  void script() {
    display();
    move(moveSpeed);
    collision();
  }

  void collision() {
    if (_x > 32 && _x < 54 && _y == 695) {
      h7 = true;
      //println("HOLE 7 IS COVERED");
    } else {
      h7 = false;
    }
    if (_x > 32 && _x < 54 && _y == 629) {
      h6 = true;
      //println("HOLE 6 IS COVERED");
    } else {
      h6 = false;
    }
    if (_x > 32 && _x < 54 && _y == 580) {
      h5 = true;
      //println("HOLE 5 IS COVERED");
    } else {
      h5 = false;
    }
    if (_x > 32 && _x < 54 && _y == 526) {
      h4 = true;
      //println("HOLE 4 IS COVERED");
    } else {
      h4 = false;
    }
    if (_x > 32 && _x < 54 && _y == 472) {
      h3 = true;
      //println("HOLE 3 IS COVERED");
    } else {
      h3 = false;
    }
    if (_x > 32 && _x < 54 && _y == 416) {
      h2 = true;
      //println("HOLE 2 IS COVERED");
    } else {
      h2 = false;
    }
    if (_x > 32 && _x < 54 && _y == 357) {
      h1 = true;
    }
    //println("HOLE 1 IS COVERED");
    else {
      h1 = false;
    }

    //h1 = false;
    //h2 = false;
    //h3 = false;
    //h4 = false;
    //h5 = false;
    //h6 = false;
    //h7 = false;
  }
}
