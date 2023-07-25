enum WallState {
  EMPTY, FULL
}

class Tile {
  private WallState _left, _top, _right, _bottom;
  
  private PImage img;
  public int rotation = 0;
  
  public boolean isAny = false;
  
  Tile(PImage image, WallState left, WallState top, WallState right, WallState bottom) {
    _left = left;
    _right = right;
    _top = top;
    _bottom = bottom;
    img = image;
  }
  
  Tile() {
    isAny = true;
  }
  
  void rotateR() {
    rotation++;
    rotation %= 4;
    
    WallState tmp = _left;
    _left = _bottom;
    _bottom = _right;
    _right = _top;
    _top = tmp;
  }
  
  Tile rotated(int n) {
    Tile nw = new Tile(this.img, _left, _top, _right, _bottom);
    nw.rotateFor(n);
    return nw;
  }
  
  void rotateFor(int n) {
    for(int i = 0; i < n; i++) rotateR();
  }
  
  boolean alignsTop(Tile other) {
    return other._bottom == _top || isAny;
  }
  boolean alignsBottom(Tile other) {
    return other._top == _bottom || isAny;
  }
  boolean alignsRight(Tile other) {
    return other._left == _right || isAny;
  }
  boolean alignsLeft(Tile other) {
    return other._right == _left || isAny;
  }
  
  public void draw(int x, int y, float s) {
    push();
    translate(x + s / 2, y + s / 2);
    rotate(rotation * PI / 2);
    translate(-s / 2, -s / 2);
    image(img, 0, 0, s, s);
    pop();
  }
}
