// Bars are created as vertical lines that help indicate the tempo of the song.
// 

public class barLine {
  float startX = 900;
  float startY = 250;
  float endX = 900;
  float endY = 750;
  float moveSpeed = 5;
  float directionX = -2; // Controls speed of the bars. 
  


  // Constructor
  barLine(float _startX, float _startY, float _endX, float _endY) { 
    startX = _startX;
    startY = _startY;
    endX = _endX;
    endY = _endY;
  }


  public void display() {
    if (startX > 43) {
    strokeWeight(3);
    stroke(75);
    line(startX, startY, endX, endY);
    //startX += speed * directionX;
    } else {
      stroke(255);
    }
  }
  
  void move(float tspeed) {
  moveSpeed = tspeed;
  startX += speed * directionX;
  endX += speed * directionX;
}

  void resetBar() {
    stroke(75);
    startX = 1053;
    endX = 1053;
  }
}
