int n = 0;
int turnNumber = 0;
int locationX = 10;
int locationY = 10;
int i = 0;
int whereAreWe = -1;
int returnwhat = -1;
boolean gameOver = false;
int validNumber;
ArrayList <Integer> temp = new ArrayList<Integer>();
int gameVictory = 0;
tttFullBoard n2[] = new tttFullBoard[9];
public void setup() {
  size(750, 1000);
  background(255);
  createBoard();
}
public void draw() {
    n2[validNumber].checkWin();
    for (int i = 0; i < 9; i++) {
        n2[i].checkWin();
        if (n2[i].getVictory() == true) {
            n2[i].whoWon();
            n2[i].setValid(false);
        }
    }
    checkTileWin();
    updateColorsAndText();
    if(returnwhat != -1) {
        n2[returnwhat].checkWin();
    }
    if(gameVictory != 0) {
        textSize(50);
        fill(0, 408, 612);
        if(gameVictory % 2 == 0) {
            text("Player 2 Wins", 150, 850);
        } else {
            text("Player 1 Wins", 150, 850);
        }
        stop();
    }
}

public void updateColorsAndText() {
  for (int i = 0; i < 9; i++) {
    n2[i].texts();
    if (validNumber == n2[i].getNumber() && !temp.contains(i)) {
      n2[i].setColor(0, 408, 612);
    } else if (temp.contains(validNumber)) {
      if (!temp.contains(i)) {
        n2[i].setColor(0, 408, 612);
      } else {
        n2[i].setColor(0, 0, 0);
      }
    } else {
      n2[i].setColor(0, 0, 0);
    }
  }
}


public void createBoard() {
  int sizeDifferenceX = 0;
  int a = 0;
  for (int i = 0; i < 3; i++) {
    n2[i] = new tttFullBoard(locationX + sizeDifferenceX, locationY, a);
    n2[i].show();
    sizeDifferenceX += 250;
    a++;
  }
  sizeDifferenceX = 0;
  for (int i = 3; i < 6; i++) {
    n2[i] = new tttFullBoard(locationX + sizeDifferenceX, locationY + 250, a);
    n2[i].show();
    sizeDifferenceX += 250;
    a++;
  }
  sizeDifferenceX = 0;
  for (int i = 6; i < 9; i++) {
    n2[i] = new tttFullBoard(locationX + sizeDifferenceX, locationY + 500, a);
    n2[i].show();
    sizeDifferenceX += 250;
    a++;
  }
  line(locationX +70, locationY, locationX+70, locationY + 210);
  line(locationX + 140, locationY, locationX+140, locationY + 210);
  line(locationX, locationY+70, locationX + 210, locationY + 70);
  line(locationX, locationY +140, locationX+210, locationY + 140);
}

public void x(int x, int y) {
  stroke(10);
  fill(255);
  line(x + 10, y + 10, x+55, y+55);
  line(x + 10, y+55, x+55, y+10);
}

public void o(int x, int y, int w, int h) {
  stroke(10);
  fill(255);
  ellipse(x+30, y +35, w, h);
}
public void biggerX(int x, int y) {
  stroke(40);
  line(x- 65, y-60, x+125, y+125);
  line(x- 65, y+125, x+125, y-60);
}

public void hitbox() {
  for (int i = 0; i < 9; i++) {
    if (validNumber == i && !temp.contains(i)) {
      // Check if the mouse is pressed within the bounds of the current board
      if (mousePressed && mouseX > n2[i].getClickSpaceX0(0) && mouseX < n2[i].getClickSpaceX3(8) && mouseY > n2[i].getClickSpaceY0(0) && mouseY < n2[i].getClickSpaceY3(8)) {
        returnwhat = i;
        validNumber = i;
        break;
      }
    }
  }
  // If the selected board is completed, allow free access to any other non-completed board
  if (temp.contains(validNumber)) {
    for (int i = 0; i < 9; i++) {
      
      if (!temp.contains(i)) {
        if (mousePressed && mouseX > n2[i].getClickSpaceX0(0) && mouseX < n2[i].getClickSpaceX3(8) && mouseY > n2[i].getClickSpaceY0(0) && mouseY < n2[i].getClickSpaceY3(8)) {
          returnwhat = i;
          validNumber = i;
          break;
        }
      }
    }
  }
}

public void mousePressed() {
  hitbox();
  if (returnwhat != -1) {
    n2[returnwhat].checker(mouseX, mouseY);
  
    returnwhat = -1;
  }
}
 public void checkTileWin() {
    checkWinTileRow(0, 1, 2);
    checkWinTileRow(3, 4, 5);
    checkWinTileRow(6, 7, 8);
    checkWinTileRow(0, 3, 6);
    checkWinTileRow(1, 4, 7);
    checkWinTileRow(2, 5, 8);
    checkWinTileRow(0, 4, 8);
    checkWinTileRow(2, 4, 6);
}

private void checkWinTileRow(int a, int b, int c) {
    if (n2[a].getWhoWon() != -1 && n2[a].getWhoWon() == n2[b].getWhoWon() && n2[b].getWhoWon() == n2[c].getWhoWon()) {
        gameVictory = n2[a].getWhoWon();
    }
}

public class tttButton {
  private int clicked;
  private int clickSpaceX1, clickSpaceY1, clickSpaceX2, clickSpaceY2;
  private boolean valid;
  private int XorO;

  public tttButton(int x, int y) {
    clicked = 0;
    clickSpaceX1 = x;
    clickSpaceX2 = x + 58;
    clickSpaceY1 = y;
    clickSpaceY2 = y + 58;
    valid = true;
    XorO = 0;
  }

  public int getClicked() {
    return clicked;
  }

  public void setClicked(int n) { //when mouse pressed, setClicked to number that of turn
    clicked = n;
  }

  public boolean getValid() {
    return valid;
  }

  public void setValidFalse() {
    valid = false;
  }

  public void show() {
    rect(clickSpaceX1 + 3, clickSpaceY1 + 6, clickSpaceX2 - clickSpaceX1, clickSpaceY2 - clickSpaceY1);
  }

  public int getClickSpaceX() {
    return clickSpaceX1;
  }

  public int getClickSpaceY() {
    return clickSpaceY1;
  }

  public int getClickSpaceX2() {
    return clickSpaceX2;
  }

  public int getClickSpaceY2() {
    return clickSpaceY2;
  }

  public int getXorO() {
    return XorO;
  }

  public void changeSquare(int n) {
    if (n % 2 == 0) {
      fill(255);
      rect(clickSpaceX1 + 3, clickSpaceY1 + 6, clickSpaceX2 - clickSpaceX1, clickSpaceY2 - clickSpaceY1);
      o(clickSpaceX1, clickSpaceY1, 50, 50);
      XorO = 1;
    } else {
      fill(255);
      XorO = 2;
      rect(clickSpaceX1 + 3, clickSpaceY1 + 6, clickSpaceX2 - clickSpaceX1, clickSpaceY2 - clickSpaceY1);
      x(clickSpaceX1, clickSpaceY1);
    }
  }
}
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