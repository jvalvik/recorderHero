class Note
{
  int _x;
  int _y;
  //int _freq;
  //float _amp;
  int r = 25;  //radius
  int _red;
  int _green;
  int _blue;
  float speed = 5;
  float directionX = -1;
  String _noteLetter;

  Note(int x, int y, int red, int green, int blue) {
    _x = x;
    _y = y;
    _red = red;
    _green = green;
    _blue = blue;
  }  

  Note(String noteLetter, int x, int y, int red, int green, int blue) {
    _x = x;
    _y = y;
    _red = red;
    _green = green;
    _blue = blue;
    _noteLetter = noteLetter;
  }

  void display() {
    if (_x > 43) {
      noStroke();
      fill(_red, _green, _blue);
      ellipse(_x, _y, r, r);
    }
  }

  void displayLetter() {
    if (_x > 43) {
      noStroke();
      fill(_red, _green, _blue);
      text(_noteLetter, _x, _y);
    }
  }

  void move(float tspeed) {
    speed = tspeed;
    _x += speed * directionX;
  }

  void script() {
    if (_noteLetter == null) {
      display();
    } else if (_noteLetter != null) {
      displayLetter();
    }
    move(moveSpeed);
    collision();
  }

  void collision() {
    if (_x > 32 && _x < 54 && _y == 695) {
      h7 = true;
      //println("HOLE 7 IS COVERED");
    } 
    if (_x > 32 && _x < 54 && _y == 629) {
      h6 = true;
      //println("HOLE 6 IS COVERED");
    } 
    if (_x > 32 && _x < 54 && _y == 580) {
      h5 = true;
      //println("HOLE 5 IS COVERED");
    } 
    if (_x > 32 && _x < 54 && _y == 526) {
      h4 = true;
      //println("HOLE 4 IS COVERED");
    } 
    if (_x > 32 && _x < 54 && _y == 472) {
      h3 = true;
      //println("HOLE 3 IS COVERED");
    } 
    if (_x > 32 && _x < 54 && _y == 416) {
      h2 = true;
      //println("HOLE 2 IS COVERED");
    }
    if (_x > 32 && _x < 54 && _y == 357) {
      h1 = true;
      //println("HOLE 1 IS COVERED");
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
