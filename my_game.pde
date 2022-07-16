PImage MyShip;
PImage Background;
PImage Saboteur;
PImage enemy_ship;
PImage ship;


int X;
int Y = 500;



int frame=0;

int bullet_X=0;
int bullet_Y=0;

int bullet_x_two = 0;
int bullet_y_two = 0;

int num_enemy = 0;
int[] enemy_x = new int[10];
int[] enemy_y = new int[10];
boolean[] enemy_live = new boolean[10];

boolean ship_live = true;
boolean bullet_fly=false; 
boolean second_bullet_fly=false;

void setup() {
  size(800, 600);

  MyShip = loadImage("img/Ships/Lightning.png");  
  Background = loadImage("img/bg.jpg");
  Saboteur = loadImage("img/Ships/Saboteur.png");

  background(Background);
}


void draw() {
  noCursor();
  background(Background);

  ship=MyShip.get(32*frame, 0, 32, 32);
  enemy_ship=Saboteur.get(32*frame, 0, 32, 32);

  X = mouseX;

  pushMatrix();
  translate(X-16, Y-16);
  scale(1.5);
  if (ship_live) {
    image(ship, 0, 0);
  }
  popMatrix();

  frame=frame+1;
  if (frame==4) {
    frame=0;
  }

  if (bullet_fly) {
    bullet_Y=bullet_Y-20;

    fill(#43a5cf);
    ellipse(bullet_X-6, bullet_Y-16, 5, 5);
    ellipse(bullet_X+22, bullet_Y-16, 5, 5);

    if (bullet_Y<=0) {
      bullet_fly=false;
    }
  }

  if (second_bullet_fly) {
    bullet_y_two=bullet_y_two-6;

    fill(#43a5cf);
    ellipse(bullet_x_two+7, bullet_y_two-20, 20, 20);

    if (bullet_y_two<=0) {
      second_bullet_fly=false;
    }
  } 


  if (num_enemy == 0) {
    num_enemy = 10;

    for (int i=0; i<num_enemy; i++) {
      enemy_x[i] = int(random(50, 750));
      enemy_y[i] = int(random(50, 60));
      enemy_live[i]=true;
    }
  }

  for (int i=0; i<10; i++) {

    if (enemy_live[i]) {
      pushMatrix();
      translate(enemy_x[i], enemy_y[i]);
      scale(1.5);
      image(enemy_ship, 0, 0);
      popMatrix();
    }
    enemy_y[i]++;
  }

  for (int i=0; i<10; i++) {
    if (int(dist(bullet_X, bullet_Y, enemy_x[i], enemy_y[i])) < 32) {
      enemy_live[i]=false;
    }
  }

  for (int i=0; i<10; i++) {
    if (int(dist(bullet_x_two, bullet_y_two, enemy_x[i], enemy_y[i])) < 32) {
      enemy_live[i]=false;
    }
  }

  for (int i=0; i<10; i++) {
    if (int(dist(X, Y, enemy_x[i], enemy_y[i])) < 32) {
      ship_live = false;
      enemy_live[i]=false;
    }
  }
}

void mouseClicked() {
  if (!mousePressed) {
    if (mouseButton==LEFT) {
      if (!bullet_fly) {
        bullet_X=X;
        bullet_Y=Y;
        bullet_fly=true;
      }
    }  
    if (mouseButton==RIGHT) {
      if (!second_bullet_fly) {
        bullet_x_two=X;
        bullet_y_two=Y;
        second_bullet_fly=true;
      }
    }
  }
}
