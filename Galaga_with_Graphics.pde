
  import processing.sound.*;

PImage ship;
PImage alien;
int speed = 7;
int x = 200;
int y = 350;
PVector bullet;
PVector bulletSpeed = new PVector(0, 10);
int counter = 0;
boolean shotFired = false;
int enemyX = 10;
int enemyY = 10;
PVector[] pixel;
boolean[] life = {true, true, true, true, true};
PVector pixelShot = new PVector(0, 0);
boolean pixelFired = false;
boolean enemyShotFired = false; // impplement 1 shot at a time function
int playerLives = 3; //Add function to game
int livesX = 20;




/*
THINGS TO ADD TO THE GAME
Player lives
Hit detector for when player is moving
Add fullScreen capability
*/


void setup()
{
  size(400, 400);
  //fullScreen();
  background(0);
  ship = loadImage("ship.png");
  alien = loadImage("galaga_bee.jpg");
  PFont font = createFont("Ariel", 30);
  textFont(font);
  SoundFile file = new SoundFile(this, "Soundtrack.mp3");
  file.play();
}
void draw()
{
  
  rectMode(RADIUS);
  //imageMode(CENTER);
  background(0);
  fill(255);
  image(ship, x, y, 50, 50);
  //rect(x, y, 20, 10);
  move();
  enemy();
  shootback();
  if(keyPressed == true && key == ' ')
    shoot();
  display();
  playerCheck();
  winChecker();
}
void move()
{
    if(key == 'a' && keyPressed == true)
      x -= speed;
    if(key == 'd' && keyPressed == true)
      x += speed;
    
}
void shoot()
{
  if(shotFired == false)
  {
    rectMode(RADIUS);
    int bulletX = x;
    int bulletY = y;
    bullet = new PVector(x, y);
    fill(0, 0, 255);
    rect(bullet.x, bullet.y, 5, 10);
    shotFired = true;
  }
  if(bullet.y < 10)
    shotFired = false;
}

void display()
{
    fill(0);
    rect(200, 0, 100, 20);
    rectMode(CORNERS);
    imageMode(CENTER);
    fill(0, 255, 0);
    for(int i = 0; i < 5; i++)
    {
      if(life[i] == true)
        image(alien, pixel[i].x+10, pixel[i].y+20, 60, 40);
      else
      {
        fill(0);
        rect(pixel[i].x, pixel[i].y, pixel[i].x+20, pixel[i].y+20);
      }
      fill(0, 255, 0);
    }
    if(shotFired == true)
    {
      rectMode(RADIUS);
      fill(0, 0, 255);
      rect(bullet.x, bullet.y, 5, 10);
      bullet.sub(bulletSpeed);
    }
    if(pixelFired == true)
    {
      rectMode(RADIUS);
      fill(255, 0, 0);
      rect(pixelShot.x, pixelShot.y, 5, 10);
      pixelShot.add(bulletSpeed);
    }
    for(int i = 0; i < playerLives; i++)
    {
        image(ship, livesX, 380, 20, 20);
        livesX += 20;
    }
    livesX = 20;
}
void enemy()
{
  fill(0, 255, 0);
  rectMode(CORNERS);
  enemyX = 10;
  enemyY = 10;
  pixel = new PVector[5];
  for(int i = 0; i < 5; i++)
  {
    pixel[i] = new PVector(enemyX, enemyY);
    rect(pixel[i].x, pixel[i].y, pixel[i].x+20, pixel[i].y+20);
    enemyX += 80;
  }
  if(shotFired == true)
  {
     for(int i = 0; i < 5; i++)
     {
        if(bullet.y <= pixel[i].y+20 && bullet.y >= pixel[i].y-20 && bullet.x >= pixel[i].x && bullet.x <= pixel[i].x+20 && life[i] == true)
        {
            life[i] = false;
            println("Hit");
        } 
     }
  }
}
void  shootback()
{
  rectMode(RADIUS);
  if(pixelFired == false)
  {
    for(int i = 0; i < 5; i++)
    {
      int randomShoot = (int)random(0, 100);
      if(randomShoot == 1)
      {
        pixelFired = true;
        pixelShot = new PVector(pixel[i].x, pixel[i].y);
      }
    }
  }
  if(pixelShot.y > 390)
    pixelFired = false;
}
void playerCheck()
{
  if(pixelFired == true)
  {
    if(pixelShot.x >= x-5 && pixelShot.x <= x+5 && pixelShot.y <= y+5 && pixelShot.y >= y-5)
    {
      if(playerLives > 0)
        playerLives--;
      else
      {
        delay(1000);
        text("Game Over", 100, 200);
        delay(1000);
        exit();
      }
    } 
  }
}
void winChecker()
{
  int gameover = 0;
  for(int i = 0; i < 5; i++)
  {
    if(life[i] == true)
      gameover++;
      
  }
  if(gameover == 0)
  {
    fill(255);
    delay(1000);
    text("Congrats on winning", 50, 200);
    delay(1000);
    exit();
  }
}