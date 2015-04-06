class EnemyArmy extends ArrayList<PVector>{
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
    for(PVector pos : this){
      if((pos.x>=width-unitWidth && direction) || (pos.x<= unitWidth && !direction))  
         GoDown();
      else
          pos.x+=(direction?actualSpeed:-actualSpeed); 
    }
  }
  void GoDown(){
    for(PVector pos : this)
      pos.y+=unitHeight;
    
    direction=!direction;
  }
  public void Draw(){
    if(this.size()==0)
      println("you won");
    else
      if(this.get(this.size()-1).y>=height-10)
        println("you lose");    
    for(PVector pos : this){
      Move();
      image(enemyImg,pos.x,pos.y,unitWidth,unitHeight);
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
        this.add(new PVector(unitWidth*k,unitHeight*i));
      }
    }
    startArmyCount=this.size();
  }
  public void Destroy(PVector p) {
    this.remove(p);
    explosion.rewind();    
    explosion.play();
    image(explosionImg,p.x,p.y);
    actualSpeed=speed.SetSpeed(Percentual());
    println("speed= "+actualSpeed);
  } // with graphical animation 
  
  float Percentual(){
    return this.size()==1?-1:(this.size()*100)/startArmyCount;  
  }
}
