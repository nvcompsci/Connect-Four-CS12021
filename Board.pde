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
  }
  
  public void placeChip() {
    Chip move = new Chip(redTurn);
    int row = (int) map(mouseY, SCALE, boardHeight + SCALE, 0, spaces.length);
    int col = (int) map(mouseX, SCALE, boardWidth + SCALE, 0, spaces[0].length);
    if (row >= 0 && row < spaces.length && col >=0 && col < spaces[0].length) {
      if (isColumnAvailable(col)) {
        row = lowestAvailableRow(col);
        System.out.printf("\nColumn %d is available. Chip drops to row index %d.",col,row);
        spaces[row][col] = move;
      }
      else {
         System.out.printf("\nColumn %d is NOT available.",col);
      }
    }
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
      if (spaces[0][col] == null) {
        return true;
      }
      else return false;
    }
  
  /**
  * 2. Tries all columns, picks the first one (leftmost) available
  * @return col - index of the column picked
  */
  private int pickFirstAvailableColumn() {
    int column = 0;
    for (int i = 0; i < spaces[0].length; i++) {
      column = i;
      if (isColumnAvailable(i)) {
        break;
      }
    }
    return column;
  }
  
  /**
  * 3. Determines row placement after chip falls, which is calculated
  * as the row with the highest index (lower on the page)
  * @param col - index of the column to check
  * @return row - index of the row where the chip will fall
  */
  private int lowestAvailableRow(int col) {
    int row = 0;
    for (int i = spaces.length-1; i > -1; i--) {
      row = i;
      if (spaces[i][col] == null) {
        break;
      }
    }
    return row;
  }
  
  /**
  * 4. Determines if the player has a four-in-a-row in this row
  * @param row - index of the row to check
  * @param isRed - true if checking red player, false if checking yellow
  * @return didWinRow - whether the player won in this row
  */
  private boolean winsThisRow(int row, boolean isRed) {
    boolean didWinRow = false;
    for (int i = 0; i < spaces[0].length - 3; i++) {
      if (spaces[row][i].isRed() && spaces[row][i+1].isRed() && spaces[row][i+2].isRed() && spaces[row][i+3].isRed()) {
        didWinRow = true;
      }
      else if (!spaces[row][i].isRed() && !spaces[row][i+1].isRed() && !spaces[row][i+2].isRed() && !spaces[row][i+3].isRed()) {
        didWinRow = true;
      }
    }
    return didWinRow;
  }
  
  /**
  * 5. Determines if the player has a four-in-a-row in this column
  * @param col - index of the column to check
  * @param isRed - true if checking red player, false if checking yellow
  * @return didWinColumn - whether the player won in this column
  */
  private boolean winsThisColumn(int col, boolean isRed) {
    boolean didWinColumn = false;
    for (int i = 0; i < spaces.length - 3; i++) {
      if (spaces[i][col].isRed() && spaces[i+1][col].isRed() && spaces[i+2][col].isRed() && spaces[i+3][col].isRed()) {
        didWinColumn = true;
      }
      else if (!spaces[i][col].isRed() && !spaces[i+1][col].isRed() && !spaces[i+2][col].isRed() && !spaces[i+3][col].isRed()) {
        didWinColumn = true;
      }
    }
    return didWinColumn;
  }
  
  /**
  * 6. Determines if the player has a four-in-a-row in any diagonal line
  * @param isRed - true if checking red player, false if checking yellow
  * @return didWinWithDiagonal - whether the player won in a diagonal
  */
  private boolean hasDiagonalWin(boolean isRed) {
    
    return false;
  }
  
  /**
  * 7. Checks all rows, columns, and diagonals for a win
  * @param isRed - true if checking red player, false if checking yellow
  * @return didWin - whether the player won
  */
  private boolean didWin(boolean isRed) {
    
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
