class EnemyArmy extends ArrayList<PVector>{
  public static final int unitWidth=50;
  public static final int unitHeight=50;
  boolean direction;
  public float speed=.005;
  public EnemyArmy(){
    direction = true;  // go to right
  }
  
  public void Move(){
    for(PVector pos : this){
      if((pos.x>=width-unitWidth && direction) || (pos.x<= unitWidth && !direction))  
         GoDown();
      else
          pos.x+=(direction?speed:-speed); 
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
  }
  public void Destroy(PVector p) {
    this.remove(p);
    explosion.rewind();
    explosion.play();
    image(explosionImg,p.x,p.y);
    speed*=(this.size()<15&& this.size()>13?2:1);
    speed*=(this.size()<5 ?7 :1);
    println("speed= "+speed);
  } // with graphical animation 
  
}
