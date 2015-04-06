class Player{
  ArrayList<Bullet> bullets;
  private static final float speed=40;
  public PVector Position;
  public Player(float x,float y){
    Position=new PVector(x,y);
    bullets= new ArrayList<Bullet>();
  }
  public void Shoot(){
    bullets.add(new Bullet(this));
  }
  public void Move(boolean right){
    
    if(!(Position.x+speed>width&&right))
      Position.x+= (right?speed:-speed);
  }
  
  public void Draw(){
    image(playerImg,Position.x,Position.y,50,50);
    for(Iterator<Bullet> it = bullets.iterator();it.hasNext();){
      Bullet b = it.next();
      if(!b.CanDraw)
        it.remove();
      else
          b.Draw();
    }
  }
}


