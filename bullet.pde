class Bullets extends ArrayList<Bullet>{
  public Bullets(){}
  public void Draw(){
  for(Iterator<Bullet> it = bullets.iterator();it.hasNext();){
      Bullet b = it.next();
      if(!b.CanDraw)
        it.remove();
      else
          b.Draw();
  }
  }
}
class Bullet{
  public static final int widthB=10;
  public static final int heightB=10;
  public float speed=10;
  public boolean CanDraw;
  public boolean Direction;
  public PVector Position;
  public Bullet(PVector p,float adjustmentX,float adjustmentY, boolean direction){
     Position=new PVector(p.x+adjustmentX,p.y+adjustmentY);  // aggiustamenti
     speed=(direction?speed:-speed);
     Direction=direction;
     CanDraw=true;
  }
  
  public void Draw(){
    if(CanDraw){
      Move();
      fill(0,255,0);
      ellipse(Position.x,Position.y,widthB,heightB);
      CanDraw= CanDraw && ((Direction && this.Position.y>0) || (!Direction && this.Position.y<height));
    }
  }
  
  void Move(){
     Enemy temp=null;
     if(Direction){
       temp=CollisionWithEnemy();
      if(temp!=null){
        enemyArmy.Destroy(temp);  
        CanDraw=false;
        println("colpito");
      }
     }
      else{
        if(Collision(player.Position,player.pWidth,player.pHeight)&&!Direction){
          println("giocatore colpito");
          player.Die();
          CanDraw=false;
        }  
      }
     this.Position.y-=speed; 
  }

   public Enemy CollisionWithEnemy(){
    Enemy temp=new Enemy(new PVector(-100,-100),false,0,0);
    EnemyArmy PossibleVictim= new EnemyArmy();
    for(Enemy e : enemyArmy){
      if(Collision(e.Position,enemyArmy.unitWidth,enemyArmy.unitHeight))
        PossibleVictim.add(e);
    }
    for(Enemy e : PossibleVictim){
      temp = (e.Position.y>temp.Position.y?e:temp);
    }
    return temp.Position.x==-100 && temp.Position.y==-100 ? null : temp;
  }
  
    boolean Collision(PVector p,float pWidth,float pHeight){
    return p.y<=Position.y+heightB/2 && p.y+pHeight>=Position.y-heightB/2-speed && p.x<=Position.x+widthB/2 && p.x+pWidth>= Position.x - widthB/2;
  }
}
  

