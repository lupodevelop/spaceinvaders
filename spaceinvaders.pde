import java.util.Iterator;
import ddf.minim.*;
int timeToShoot=200;
int t;
PImage explosionImg;
PImage playerImg;
PImage enemyImg;
Player player;
Bullets bullets;
EnemyArmy enemyArmy;
AudioPlayer shootPlayer, explosion;
Minim minim;
boolean finished;
void setup() {
   size(800,768);
   finished=false;
   frameRate(120);
   minim= new Minim(this);
   explosion= minim.loadFile("data/sound/explosion.wav");  
   shootPlayer=minim.loadFile("data/sound/shoot.wav");
   enemyArmy = new EnemyArmy();
   bullets=new Bullets();
   enemyArmy.InitializeArmy(10,10);  // y=7 perché sfora il limite 
   playerImg= loadImage("data/img/player.jpg");
   explosionImg=loadImage("data/img/Explosion.png");
   enemyImg=loadImage("data/img/enemy.jpg");
   player = new Player(width/2,height-120);
}

void draw() {
  if(!finished){
  background(0);
  player.Draw();
  enemyArmy.Draw();
  bullets.Draw();
  }
}

void keyPressed(){
  if(key==CODED){
  if(keyCode==LEFT)
    player.Move(false);
  else
    if(keyCode==RIGHT)
      player.Move(true);
  }
  if(key==' '){
    if(millis()-t>timeToShoot){
      player.Shoot();
      shootPlayer.rewind();
      shootPlayer.play();
      t=millis();
    }
  }
  if(key=='r' && finished){
    setup();
  }
}





