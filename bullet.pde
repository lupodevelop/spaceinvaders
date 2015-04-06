class Bullet{
  public static final int widthB=10;
  public static final int heightB=10;
  private static final float speed=10;
  public boolean CanDraw;
  public PVector Position;
  public Bullet(Player p){
    if(p!=null){
      Position=new PVector(p.Position.x+25,p.Position.y+19);  // aggiustamenti
      CanDraw=true;
    }
    else{
      println("something strange in Bullet!");
    }
  }
  
  public void Draw(){
    if(CanDraw){
      Move();
      fill(0,255,0);
      ellipse(Position.x,Position.y,widthB,heightB);
      CanDraw= CanDraw && Position.y>=0;
    }
    }
  
  void Move(){
     PVector temp=Collision();
      if(temp!=null){
        enemyArmy.Destroy(temp);  
        CanDraw=false;
        println("colpito");
      }
      else
        this.Position.y-=speed;
  }

  public PVector Collision(){
    PVector temp=new PVector(0,0);
    ArrayList<PVector> PossibleVictim= new ArrayList<PVector>();
    for(PVector p : enemyArmy){
      if(p.y<=Position.y+heightB/2 && p.y+enemyArmy.unitHeight>=Position.y-heightB/2-speed && p.x<=Position.x+widthB/2 && p.x+enemyArmy.unitWidth>= Position.x - widthB/2)
        PossibleVictim.add(p);
    }
    println(enemyArmy.size()-PossibleVictim.size());
    for(PVector p : PossibleVictim){
      temp = (p.y>temp.y?p:temp);
    }
    return temp.x==0 && temp.y==0 ? null : temp;
  }
}
  

