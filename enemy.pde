class EnemyArmy extends ArrayList<Enemy>{
  public static final int unitWidth=50;
  public static final int unitHeight=50;
  int startArmyCount;
  boolean direction;
  float actualSpeed;
  float startSpeed=.005;
  float shootTime=2500;
  float lastMillis;
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
    if(millis()-lastMillis>shootTime){
      this.Shooters().RandomShoot();
      lastMillis=millis();
    }
    if(this.get(this.size()-1).Position.y>=player.Position.y){
       text("earth is invaded!",width/2,height/2);
       finished=true;   
    }
    for(Enemy e : this){
      Move();
      e.Draw();
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
        this.add(new Enemy(new PVector(unitWidth*k,unitHeight*i),i==y-1,unitWidth,unitHeight));  // canShoot = true per quelli nella fila più bassa
      }
    }
    startArmyCount=this.size();
  }
  public void Destroy(Enemy e) {
    this.remove(e);
    player.Points+=actualSpeed/startSpeed;
    if(this.size()==0){
      text("you win",width/2,height);
      finished =true;
      player.HasWon=true;
    }
    if(e.CanShoot)
      AssignShooter(e.Position);
    explosion.rewind();    
    explosion.play();
    e.Explosion();
    actualSpeed=speed.SetSpeed(Percentual());
  } // with graphical animation 
  
  public void AssignShooter(PVector deadShooterPos){
    if(deadShooterPos.y>=unitHeight){
      PVector next = new PVector(deadShooterPos.x,deadShooterPos.y-unitHeight);
      Enemy e=Find(next);
      if(e!=null){
        e.CanShoot=true;
        println("OMG funzia");
      }
      else
          AssignShooter(next);
    }
  }
  
  public void RandomShoot(){  // runs(?)
    if(this.size()>0)
      this.get((int)random(this.size()-1)).Shoot();
  }
  EnemyArmy Shooters(){
    EnemyArmy shooters = new EnemyArmy();
    for(Enemy e : this){
      if(e.CanShoot)
        shooters.add(e);
    }
    return shooters;
  }
  public Enemy Find(PVector position){
    Enemy temp= new Enemy(position,false,0,0);
    for(Enemy e : this){
      if(e.Equals(temp))
        return e;
    }
    return null;
  }
  
  float Percentual(){
    return this.size()==1?-1:(this.size()*100)/startArmyCount;  
  }
}


class Enemy{
  int UnitWidth;
  int UnitHeight;
  public boolean CanShoot;
  public PVector Position;
  
  public Enemy(PVector position,boolean canShoot,int unitWidth,int unitHeight){
    CanShoot=canShoot;
    Position=position;
    UnitWidth=unitWidth;
    UnitHeight=unitHeight;
  }
  public void Draw(){
    image(enemyImg,Position.x,Position.y,UnitWidth,UnitHeight);
  }
  
  public void Shoot(){
    
   if(CanShoot)
     bullets.add(new Bullet(this.Position,UnitWidth/2,UnitHeight,false));  // non ancora usabile
  }
  
  public void Explosion(){
    image(explosionImg,Position.x,Position.y,UnitWidth,UnitHeight);
  }
  
  public boolean Equals(Enemy e){
    return e.Position.x==this.Position.x&&e.Position.y==this.Position.y;
  }
}
