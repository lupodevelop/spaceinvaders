class EnemyArmy extends ArrayList<Enemy>{
  public static final int unitWidth=50;
  public static final int unitHeight=50;
  int startArmyCount;
  boolean direction;
  float actualSpeed;
  float startSpeed=.005;
  public Speed speed;
  public EnemyArmy(){
    direction = true;  // go to right
    actualSpeed=startSpeed;
    speed=new Speed(startSpeed);
  }
  
  public void Move(){
    for(Enemy e : this){
      if((e.Position.x>=width-unitWidth && direction) || (e.Position.x<= unitWidth && !direction))  
         GoDown();
      else
          e.Position.x+=(direction?actualSpeed:-actualSpeed); 
    }
  }
  void GoDown(){
    for(Enemy e : this)
      e.Position.y+=unitHeight;
    
    direction=!direction;
  }
  public void Draw(){
    if(this.size()==0)
      println("you won");
    else
      if(this.get(this.size()-1).Position.y>=height-10)
        println("you lose");    
    for(Enemy e : this){
      Move();
      e.Draw(unitWidth,unitHeight);
    }
  }
  void InitializeArmy(int x,int y){  // quante per riga e colonna
    int maxX=width/unitWidth;
    int maxY=(height/unitHeight)/2;
    println(maxX + " " + maxY);
    x=maxX>x?x:maxX;
    y=maxY>y?y:maxY;
    for(int i = 0; i< y;i++){
      for(int k=0;k<x;k++){
        this.add(new Enemy(new PVector(unitWidth*k,unitHeight*i),i==y-1));  // canShoot = true per quelli nella fila più bassa
      }
    }
    startArmyCount=this.size();
  }
  public void Destroy(Enemy e) {
    this.remove(e);
    explosion.rewind();    
    explosion.play();
    e.Explosion();
    actualSpeed=speed.SetSpeed(Percentual());
    println("speed= "+actualSpeed);
  } // with graphical animation 
  
  float Percentual(){
    return this.size()==1?-1:(this.size()*100)/startArmyCount;  
  }
}

class Enemy{
  boolean CanShoot;
  PVector Position;
  
  public Enemy(PVector position,boolean canShoot){
    CanShoot=canShoot;
    Position=position;
  }
  public void Draw(int unitWidth,int unitHeight){
    image(enemyImg,Position.x,Position.y,unitWidth,unitHeight);
  }
  
  public void Shoot(){
    /*
   if(canShoot)
     bullets.add(new Bullet(this.Position,false));  // non ancora usabile
     */
  }
  
  public void Explosion(){
    image(explosionImg,Position.x,Position.y);
  }
}
