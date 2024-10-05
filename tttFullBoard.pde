public class tttFullBoard {
  private int locationX, locationY;
  private tttButton [] n1;
  private int whoWon;
  private int number;
  private boolean valid;
  private boolean victory;
  private int color1, color2, color3;
  public tttFullBoard(int x, int y, int z) {
    locationX = x;
    locationY = y;
    n1 = new tttButton[9];
    whoWon = -1;
    number = z;
    valid = true;
    victory = false;
    color1 = 0;
    color2 = 0;
    color3 = 0;
  }
  public void show() {
    fill(255);
    createSquare();

  }
  public void createSquare() {
    int sizeDifferenceX = 0;
    for (int i = 0; i < 3; i++) {
      n1[i] = new tttButton(locationX + sizeDifferenceX, locationY);
      n1[i].show();
      sizeDifferenceX += 73;
    }
    sizeDifferenceX = 0;
    for (int i = 3; i < 6; i++) {
      n1[i] = new tttButton(locationX + sizeDifferenceX, locationY + 70);
      n1[i].show();
      sizeDifferenceX += 73;
    }
    sizeDifferenceX = 0;
    for (int i = 6; i < 9; i++) {
      n1[i] = new tttButton(locationX + sizeDifferenceX, locationY + 140);
      n1[i].show();
      sizeDifferenceX += 73;
    }
    line(locationX +70, locationY, locationX+70, locationY + 210);
    line(locationX + 140, locationY, locationX+140, locationY + 210);
    line(locationX, locationY+70, locationX + 210, locationY + 70);
    line(locationX, locationY +140, locationX+210, locationY + 140);
  }
  public void checkWin() {
    checkWinRow(0, 1, 2);
    checkWinRow(3, 4, 5);
    checkWinRow(6, 7, 8);
    checkWinRow(0, 3, 6);
    checkWinRow(1, 4, 7);
    checkWinRow(2, 5, 8);
    checkWinRow(0, 4, 8);
    checkWinRow(2, 4, 6);
  }

private void checkWinRow(int a, int b, int c) {
    if (n1[a].getXorO() != 0 && n1[a].getXorO() == n1[b].getXorO() && n1[b].getXorO() == n1[c].getXorO()) {
        whoWon = n1[a].getXorO();
        victory = true;
    }
}
  public int getClickSpaceX0(int i) {
    return n1[i].getClickSpaceX();
  }
  public int getClickSpaceY0(int i) {
    return n1[i].getClickSpaceY();
  }
  public int getClickSpaceX3(int i) {
    return n1[i].getClickSpaceX2();
  }
  public int getClickSpaceY3(int i) {
    return n1[i].getClickSpaceY2();
  }
  public void checker(int i, int j) {
    for (int a = 0; a < 9; a++) {
      if (i > n1[a].getClickSpaceX() && i < n1[a].getClickSpaceX2() && j > n1[a].getClickSpaceY() && j < n1[a].getClickSpaceY2() && validNumber == number && n1[a].getValid()) {
        n1[a].changeSquare(n);
        n += 1;
        n1[a].setClicked(n);
        n1[a].setValidFalse();
        checkWin();
        validNumber = a; // Update validNumber based on the current player's turn
        return; // Exit the loop once a valid move is made
      }
    }
  }
  public void whoWon(){
    if (whoWon == 1) {
        o(n1[4].getClickSpaceX(), n1[4].getClickSpaceY(), 200, 200);
        temp.add(number);
    } else if (whoWon == 2) {
        biggerX(n1[4].getClickSpaceX(), n1[4].getClickSpaceY());
        temp.add(number);
    }
}
  public int getWhoWon() {
    return whoWon;
  }
  public boolean getValid() {
    return valid;
  }
  public void setValid(boolean x) {
    valid = x;
  }
  public int getNumber() {
    return number;
  }
  public boolean getVictory(){
    return victory;
  }
  public void setColor(int i, int j, int k){
    color1 = i;
    color2 = j;
    color3 = k;
  }
  public void texts(){
    fill(color1,color2,color3);
    textSize(25);
    text(number + 1,locationX + 100, locationY + 225); 
  }
}
