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
  //System.out.println(returnwhat);
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

