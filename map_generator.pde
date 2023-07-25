Tile[] tileTypes = new Tile[17];

final int tileWidth = 25;

class Generator {
  private int[] tiles;
  
  private int w, h;
  
  Generator() {
    tileTypes[0] = new Tile(loadImage("res/tile0.png"), WallState.EMPTY, WallState.EMPTY, WallState.EMPTY, WallState.EMPTY);
    tileTypes[1] = new Tile(loadImage("res/tile0.png"), WallState.EMPTY, WallState.EMPTY, WallState.EMPTY, WallState.EMPTY);
    
    tileTypes[2] = new Tile(loadImage("res/tile2.png"), WallState.EMPTY, WallState.EMPTY, WallState.FULL, WallState.EMPTY);
    tileTypes[3] = tileTypes[2].rotated(1);
    tileTypes[4] = tileTypes[2].rotated(2);
    tileTypes[5] = tileTypes[2].rotated(3);

    tileTypes[6] = new Tile(loadImage("res/tile3.png"), WallState.EMPTY, WallState.FULL, WallState.FULL, WallState.EMPTY);
    tileTypes[7] = tileTypes[6].rotated(1);
    tileTypes[8] = tileTypes[6].rotated(2);
    tileTypes[9] = tileTypes[6].rotated(3);
    
    tileTypes[10] = new Tile(loadImage("res/tile4.png"), WallState.FULL, WallState.FULL, WallState.FULL, WallState.EMPTY);
    tileTypes[11] = tileTypes[10].rotated(1);
    tileTypes[12] = tileTypes[10].rotated(2);
    tileTypes[13] = tileTypes[10].rotated(3);
    
    tileTypes[14] = new Tile(loadImage("res/tile5.png"), WallState.FULL, WallState.FULL, WallState.FULL, WallState.FULL);

    tileTypes[15] = new Tile(loadImage("res/tile6.png"), WallState.FULL, WallState.EMPTY, WallState.FULL, WallState.EMPTY);
    tileTypes[16] = tileTypes[15].rotated(1);

    w = width / tileWidth;
    h = height / tileWidth;
  
    tiles = new int[w * h];
    for(int i = 0; i < tiles.length; i++) tiles[i] = -1;
    
    generate();
  }
  
  boolean hasUnassigned() {
    for(int i : tiles) if(i == -1) return true;
    return false;
  }
  
  void generate() {
    tiles[0] = (int)random(tileTypes.length);
    for(int i = 1; i < w; i++) { // set upper row
      tiles[i] = getCompatibleTileLeft(tiles[i - 1]);
    }
    for(int j = 1; j < h; j++) {
      for(int i = 0; i < w; i++) { // set everything else
        tiles[i + j * w] = getCompatibleTileLeftTop(getTile(i, j - 1), getTile(i - 1, j));
      }
    } //<>//
  }
  
  int getTile(int x, int y) {
    if(x < 0 || x >= w || y < 0 || y >= h) return -1;
    return tiles[x + y * w];
  }
  
  int getCompatibleTileLeftTop(int topTile, int leftTile) {
    Tile ttr = getTileType(topTile);
    Tile ltr = getTileType(leftTile);
    Tile rndTile;
    int tlIdx;
    boolean condition;
    do {
      tlIdx = (int)random(tileTypes.length);
      rndTile = getTileType(tlIdx);
      condition = (rndTile.alignsLeft(ltr) || ltr.isAny) && (rndTile.alignsTop(ttr) || ttr.isAny);
    } while(!condition);
    return tlIdx;
  }
  
  int getCompatibleTileLeft(int tile) {
    Tile refTile = getTileType(tile);
    Tile rndTile;
    int tlIdx;
    do {
      tlIdx = (int)random(tileTypes.length);
      rndTile = getTileType(tlIdx);
    } while(!rndTile.alignsLeft(refTile));
    return tlIdx;
  }
  
  int getCompatibleTileTop(int tile) {
    Tile refTile = getTileType(tile);
    Tile rndTile;
    int tlIdx;
    do {
      tlIdx = (int)random(tileTypes.length);
      rndTile = getTileType(tlIdx);
    } while(!rndTile.alignsTop(refTile));
    return tlIdx;
  }
  
  Tile getTileType(int idx) {
    if(idx < 0 || idx >= tileTypes.length) return new Tile();
    return tileTypes[idx];
  }
  
  void draw() {
    for(int i = 0; i < w; i++) {
      for(int j = 0; j < h; j++) {
        tileTypes[tiles[i + j * w]].draw(i * tileWidth, j * tileWidth, tileWidth);
      }
    }
  }
}
