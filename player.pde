class Player{
  private static final float speed=40;
  public float pWidth=50;
  public float pHeight=50;
  public PVector Position;
  public Player(float x,float y){
    Position=new PVector(x,y);
  }
  public void Shoot(){
    bullets.add(new Bullet(this.Position,pWidth/2,5,true));
  }
  public void Move(boolean right){
    
    if(!(Position.x+speed>width&&right))
      Position.x+= (right?speed:-speed);
  }
  public void Draw(){
    image(playerImg,Position.x,Position.y,pWidth,pHeight);
    }
}


