public class Chip {
  //private int x, y;
  private boolean isRed;
  
  public Chip(boolean isRed) {
    this.isRed = isRed;
  }
  
  public void draw(PVector pos) {
    color c = isRed ? #FF0000 : #FFFF00;
    fill(c);
    circle(pos.x, pos.y, SCALE);
  }
  
  public boolean isRed() {
    return isRed;
  }
}
