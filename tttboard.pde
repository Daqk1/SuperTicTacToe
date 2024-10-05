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
