public class Board {
  int[][] spaces = new int[6][7];

  public void draw() {
    int margin = SCALE;
    fill(color(50, 0, 200));
    rect(margin, margin, SCALE * spaces[0].length, SCALE * spaces.length);
    for (int i = 0; i < spaces.length; i++) {
      for (int j = 0; j < spaces[0].length; j++) {
        drawEmptySpace(i, j);
      }
    }
  }

  private void drawEmptySpace(int r, int c) {
    fill(255);
    circle(c * SCALE, r * SCALE, SCALE);
  }
}
