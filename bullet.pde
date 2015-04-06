class Bullet{
  public static final int widthB=10;
  public static final int heightB=10;
  public float speed=10;
  public boolean CanDraw;
  public boolean Direction;
  public PVector Position;
  public Bullet(PVector p, boolean direction){
     float adjustmentX = direction?23:-23;
     float adjustmentY = direction?25:-25;
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
     PVector temp=null;
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
          CanDraw=false;
        }  
      }
     this.Position.y-=speed; 
  }

   public PVector CollisionWithEnemy(){
    PVector temp=new PVector(-100,-100);
    ArrayList<PVector> PossibleVictim= new ArrayList<PVector>();
    for(PVector p : enemyArmy){
      if(Collision(p,enemyArmy.unitWidth,enemyArmy.unitHeight))
        PossibleVictim.add(p);
    }
    for(PVector p : PossibleVictim){
      temp = (p.y>temp.y?p:temp);
    }
    return temp.x==-100 && temp.y==-100 ? null : temp;
  }
  
    boolean Collision(PVector p,float pWidth,float pHeight){
    return p.y<=Position.y+heightB/2 && p.y+pHeight>=Position.y-heightB/2-speed && p.x<=Position.x+widthB/2 && p.x+pWidth>= Position.x - widthB/2;
  }
}
  

