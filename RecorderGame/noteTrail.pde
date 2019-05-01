class noteTrail
{
  int _x;
  int _y;
  int _w;
  int _h;
  int _radii; //radii for all four corners (how sharp the edge is)
  int _red;
  int _green;
  int _blue;
  float speed = 5;
  float directionX = -1;

  noteTrail(int x, int y, int w, int h, int radii, int red, int green, int blue) {
    _x = x;
    _y = y;
    _w = w;
    _h = h;
    _radii = radii;
    _red = red;
    _green = green;
    _blue = blue;
  }  

  void display() {
    if (_x > 43) {
    noStroke();
    fill(_red, _green, _blue);
    rect(_x, _y, _w, _h, _radii);
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
}
