
//population parameters
int population_size = 100;
float maxspeed = 8;
float maxforce = 2.5;
float maxPerception = 150;
float healthloss = 0.01;
boolean dead_leave_food = true;

//DNA parameters
float mr = 0.04;
float mutation_weight = 0.1;
float reproduction_rate = 0.005;

//Environment parameters
int food_number = 60;
int poison_number = 30;
float food_rate = 0.2;
float poison_rate = 0.1;
float poisonNutrition = -0.5;
float foodNutrition = +0.6;

// 2 Global objects
Population pop;
Environment env;

void setup(){
  size(1870,1020);
  pop = new Population(population_size);
  env = new Environment(food_number,poison_number);
}


void draw(){
  background(0);
  frameRate(40);
  pop.live();
  env.run();
  pop.calculateAverage();
}


// make new Agents by dragging the mouse
void mouseDragged(){
  PVector mouse = new PVector(mouseX,mouseY);
  Agent newAgent = new Agent(mouse, new Dna());
  pop.addAgent(newAgent);
}
//fast forward 400 frames(updates)
void mousePressed(){
  for(int i = 0; i<400; i++ ){
    pop.live();
    env.run();
  }
}
