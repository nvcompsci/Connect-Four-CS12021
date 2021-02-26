final static int SCALE = 75;
Board board = new Board();

public void setup() {
  size(800, 800);
}
public void draw() {
  background(200);
  board.draw();
}
