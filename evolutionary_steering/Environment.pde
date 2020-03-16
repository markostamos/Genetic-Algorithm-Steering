class Environment{
  ArrayList<PVector> food;
  ArrayList<PVector> poison;


  Environment(int fNum, int pNum){
    food = new ArrayList<PVector>();
    poison = new ArrayList<PVector>();
    for (int i = 0 ; i < fNum ; i++){
      PVector loc = new PVector(random(30,width-30),random(30,height-30));
      food.add(loc);
    }
    for (int i = 0 ; i < pNum ; i++){
      PVector loc = new PVector(random(30,width-30),random(30,height-30));
      poison.add(loc);
    }

  }

  void display(){
    for (PVector f : food){
        fill(0,255,0);
        noStroke();
        ellipse(f.x,f.y,8,8);
    }
    for (PVector p : poison){
        fill(255,0,0);
        noStroke();
        ellipse(p.x,p.y,8,8);
    }

  }
  // Randomly make new Food and Poison
  // Poison is capped at 300 units
  void evolve(){
    float r = random(1);
    if (r<food_rate){
      PVector loc = new PVector(random(30,width-30),random(30,height-30));
      food.add(loc);
    }
    if (r<poison_rate && poison.size()<300){
      PVector loc = new PVector(random(30,width-30),random(30,height-30));
      poison.add(loc);
    }
  }
  void run(){
    evolve();
    display();
  }
  void addFood(PVector loc){
    food.add(loc);
  }
}
