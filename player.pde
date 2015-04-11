class Player{
  private static final float speed=40;
  public float Points;
  public int lifes=3;  // partiamo con 3
  public float pWidth=50;
  public float pHeight=50;
  public PVector Position;
  public boolean HasWon=false;
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
    text("you have "+lifes+" lifes",width-100,height-20);
    text("you have "+Points+" points",width-100,height-50);
  }
  
  public void Die(){
    image(explosionImg,Position.x,Position.y,pWidth,pHeight);
    lifes--;
    if(lifes==0){
      finishMessage="you lose";
      finished=true;
      draw();
    }
  }
}


