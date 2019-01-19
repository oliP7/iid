class Button {
  final static int W = 60, H = 40;
  final static color BTNC = #00FFFF, TXTC = 0;
 
  final String label;
  final short x, y, xW, yH;
 
  Button(String txt, int xx, int yy) {
    label = txt;
 
    x = (short) xx;
    y = (short) yy;
 
    xW = (short) (xx + W);
    yH = (short) (yy + H);
  }
 
  void display() {
    fill(BTNC);
    rect(x, y, W, H);
 
    fill(TXTC);
    text(label, x + W/2, y + H/2);
  }
 
  boolean hasClicked() {
    return mouseX > x & mouseX < xW & mouseY > y & mouseY < yH;
  }
}
