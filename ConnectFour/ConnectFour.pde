final static int SCALE = 75;
Board board = new Board();
boolean redTurn = true;

public void setup() {
  size(675, 600);
}
public void draw() {
  background(200);
  board.draw();
  
  outlineSelection();
}

public void mouseReleased() {
  board.placeChip();
  redTurn = !redTurn;
}

private void outlineSelection() {
  noFill();
  strokeWeight(5);
  stroke(#00FF00);
  int col = (int) map(mouseX, SCALE, board.boardWidth + SCALE, 0, board.spaces[0].length);
  if (col >= 0 && col < board.spaces[0].length)
    rect(col * SCALE + SCALE, SCALE, SCALE, board.boardHeight);
  noStroke();
}
