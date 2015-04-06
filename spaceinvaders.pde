import java.util.Iterator;
import ddf.minim.*;
int timeToShoot=200;
int t;
PImage explosionImg;
PImage playerImg;
PImage enemyImg;
Player player;
EnemyArmy enemyArmy;
AudioPlayer shootPlayer, explosion;
Minim minim;
// does not have image 
void setup() {
   minim= new Minim(this);
   explosion= minim.loadFile("sound/explosion.wav");  
   shootPlayer=minim.loadFile("sound/shoot.wav");
   enemyArmy = new EnemyArmy();
   size(1360,768);
   enemyArmy.InitializeArmy();
   playerImg= loadImage("img/player.jpg");
   explosionImg=loadImage("img/Explosion.png");
   enemyImg=loadImage("img/enemy.jpg");
   player = new Player(width/2,height-120);
}

void draw() {
  background(0);
  player.Draw();
  enemyArmy.Draw();
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
}




