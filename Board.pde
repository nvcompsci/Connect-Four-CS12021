public class Board {
  Chip[][] spaces = new Chip[6][7];
  private int boardWidth, boardHeight;

  public Board() {
    boardWidth = spaces[0].length * SCALE;
    boardHeight = spaces.length * SCALE;
  }

  public void draw() {
    int margin = SCALE;
    fill(color(50, 0, 200));
    rect(margin, margin, boardWidth, boardHeight);
    for (int i = 0; i < spaces.length; i++) {
      for (int j = 0; j < spaces[0].length; j++) {
        PVector pos = getCoordinates(i, j);
        if (spaces[i][j] == null)
          drawEmptySpace(pos);
        else
          spaces[i][j].draw(pos);
      }
    }
    for (int i = 0; i < spaces.length; i++) {
  //  System.out.println(winsThisRow( 4, spaces[4][i].isRed()));
  }
  }

  public void placeChip() {
    Chip move = new Chip(redTurn);
    int row = (int) map(mouseY, SCALE, boardHeight + SCALE, 0, spaces.length);
    int col = (int) map(mouseX, SCALE, boardWidth + SCALE, 0, spaces[0].length);
    if (row >= 0 && row < spaces.length && col >=0 && col < spaces[0].length)
      spaces[row][col] = move;
  }

  private void drawEmptySpace(PVector pos) {
    fill(255);
    circle(pos.x, pos.y, SCALE);
  }

  private PVector getCoordinates(int r, int c) {
    int x = (int) map(c, 0, spaces[0].length, SCALE, boardWidth + SCALE) + SCALE / 2;
    int y = (int) map(r, 0, spaces.length, SCALE, boardHeight + SCALE) + SCALE / 2;
    return new PVector(x, y);
  }

  /**
   * 1. Determines if the column is available (not full)
   * @param col - index of the column to check
   * @return isAvailable - whether the column is available or not
   */
  private boolean isColumnAvailable(int col) {
    boolean isAvailable = false;
    for (int i = 0; i < spaces.length; i++) {
      if ( spaces[i][col] == null) {
        isAvailable = true;
      }
    }
    return isAvailable;
  }

  /**
   * 2. Tries all columns, picks the first one (leftmost) available
   * @return col - index of the column picked
   */
  private int pickFirstAvailableColumn() {
    int n = 7;
    for (int i = 0; i < spaces[0].length; i++) {
     if (isColumnAvailable(i) == true && i < n) {
       n = i;
     }
    }
    return n;
  }

  /**
   * 3. Determines row placement after chip falls, which is calculated
   * as the row with the highest index (lower on the page)
   * @param col - index of the column to check
   * @return row - index of the row where the chip will fall
   */
  private int lowestAvailableRow(int col) {
    int h = -1;
    for (int i = 0; i < spaces.length; i++) {
     if ( i > h && spaces[i][col] == null) {
      h = i; 
     }
    }
    return h;
  }

  /**
   * 4. Determines if the player has a four-in-a-row in this row
   * @param row - index of the row to check
   * @param isRed - true if checking red player, false if checking yellow
   * @return didWinRow - whether the player won in this row
   */
  private boolean winsThisRow(int row, boolean isRed) {
    boolean rowWin = false;
    for(int i = 0; i < spaces[0].length-3; i++) {
     if (spaces[row][i] != null && spaces[row][i].isRed()==spaces[row][i+1].isRed() && spaces[row][i].isRed()==spaces[row][i+2].isRed() && spaces[row][i].isRed()==spaces[row][i+3].isRed()) {
      rowWin = true; 
     }
    }
    return rowWin;
  }

  /**
   * 5. Determines if the player has a four-in-a-row in this column
   * @param col - index of the column to check
   * @param isRed - true if checking red player, false if checking yellow
   * @return didWinColumn - whether the player won in this column
   */
  private boolean winsThisColumn(int col, boolean isRed) {
    boolean colWin = false;
    for (int i = 0; i < spaces.length-3; i++) {
      if (spaces[i][col] != null && spaces[i][col].isRed()==spaces[i+1][col].isRed() && spaces[i][col].isRed()==spaces[i+2][col].isRed() && spaces[i][col].isRed()==spaces[i+3][col].isRed()) {
      colWin = true; 
     }
    }
    return colWin;
  }

  /**
   * 6. Determines if the player has a four-in-a-row in any diagonal line
   * @param isRed - true if checking red player, false if checking yellow
   * @return didWinWithDiagonal - whether the player won in a diagonal
   */
  private boolean hasDiagonalWin(boolean isRed) {
    boolean diagonalWin = false;
    for (int i = 0; i < spaces.length-3; i++) {
     for (int j = 0; j < spaces[0].length-3; j++) {
       if (spaces[i][j] != null && spaces[i][j].isRed()==spaces[i+1][j+1].isRed() && spaces[i][j].isRed()==spaces[i+2][j+2].isRed() && spaces[i][j].isRed() == spaces[i+3][j+3].isRed()) {
        diagonalWin = true; 
       }
     }
    }
    for (int i = spaces.length -1; i > 2; i--) {
     for (int j = 0; j<spaces[0].length-3; j++) {
      if (spaces[i][j] !=null && spaces[i][j].isRed()==spaces[i-1][j+1].isRed() && spaces[i][j].isRed()==spaces[i-2][j+2].isRed() && spaces[i][j].isRed() == spaces[i-3][j+3].isRed()) {
       diagonalWin=true; 
      }
     }
    }
    return diagonalWin;
  }

  /**
   * 7. Checks all rows, columns, and diagonals for a win
   * @param isRed - true if checking red player, false if checking yellow
   * @return didWin - whether the player won
   */
  private boolean didWin(boolean isRed) {
    if (hasDiagonalWin(isRed)==true) return true;
    for (int col = 0; col < spaces[0].length; col++){
     if (winsThisColumn(col, isRed)==true) return true;
    }
    for (int row = 0; row < spaces.length; row++) {
     if (winsThisRow(row, isRed)==true) return true; 
    }
    return false;
  }

  /**
   * 8. Calculates best move for the player based on the board
   * @param isRed - true if checking red player, false if checking yellow
   * @return col - index of the column picked
   */
  private int pickBestColumn(boolean isRed) {
    isRed = false;

    return 0;
  }
}
