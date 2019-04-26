// Bars are created as vertical lines that help indicate the tempo of the song.
// 

public class barLine {
  float startX = 900;
  float startY = 250;
  float endX = 900;
  float endY = 750;
  float directionX = -1; // Controls speed of the bars. 
  


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
    } else {
      stroke(255);
    }
  }
  
  void move(float tspeed) {
  moveSpeed = tspeed;
  startX += moveSpeed * directionX;
  endX += moveSpeed * directionX;
}

  void resetBar() {
    stroke(75);
    startX = 1053;
    endX = 1053;
  }
}
