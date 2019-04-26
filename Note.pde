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
  }

  void sound(int freq, float amp) {
    _freq = freq;
    _amp = amp;
    if (_x < 43) {
      sine.play(freq,amp);
    }
  }
}
