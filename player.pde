class Player{
  ArrayList<Bullet> bullets;
  private static final float speed=40;
  public float pWidth=50;
  public float pHeight=50;
  public PVector Position;
  public Player(float x,float y){
    Position=new PVector(x,y);
    bullets= new ArrayList<Bullet>();
  }
  public void Shoot(){
    bullets.add(new Bullet(this.Position,true));
  }
  public void Move(boolean right){
    
    if(!(Position.x+speed>width&&right))
      Position.x+= (right?speed:-speed);
  }
  
  public void Draw(){
    image(playerImg,Position.x,Position.y,pWidth,pHeight);
    for(Iterator<Bullet> it = bullets.iterator();it.hasNext();){
      Bullet b = it.next();
      if(!b.CanDraw)
        it.remove();
      else
          b.Draw();
    }
  }
}


