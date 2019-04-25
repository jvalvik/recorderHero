class Bullet
{
  int _x;
  int _y;
  int r = 27;  //radius
  float speed;
  int directionX = -1;
  
  Bullet(int x, int y) {
    _x = x;
    _y = y;
  }  

  void display() {
    if (_x > width/14) {
    noStroke();
    fill(255,0,0);
    circle(_x, _y, r);
    }
  }

  void move(float tspeed) {
    speed = tspeed;
    _x += speed * directionX;
  }
}
