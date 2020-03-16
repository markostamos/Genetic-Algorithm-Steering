class Agent{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float health;
  Dna dna;


  Agent(PVector l , Dna dna_){
    location = l.get();
    velocity = PVector.random2D();
    acceleration = new PVector(0,0);
    health = 1;
    dna = dna_;
    velocity.setMag(dna.speed);
  }

  void applyForce(PVector f){
    acceleration.add(f);
  }
  // Velocity = Velocity + acceleration
  // Location = Location + Velocity

  void update(){
    health-=healthloss;
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(dna.speed);
    acceleration.mult(0);
  }

  void display(){

    pushMatrix();
    translate(location.x,location.y);
    rotate(velocity.heading());
    // Change color according to health value
    color gr = color(0, 255, 0);
    color rd = color(255, 0, 0);
    color col = lerpColor(rd, gr, health);
    fill(col);
    stroke(col);

    rectMode(CENTER);
    rect(0,0,35,8);
    popMatrix();
  }
  void run(){
    boundaries();
    behaviors();
    reproduce();
    update();
    display();
  }
  boolean isDead(){
    return health<0 || health == 0;
  }
  // Craig Reynolds' steering algorithm
  // Desired =  Target - location
  // Desired_Direction = Current_Velocity + Steering_Force
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.setMag(dna.speed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  // If close to the edges seek the center of the window
  void boundaries(){
    if ((location.x>width-20) ||(location.x<30) ||  (location.y<30) || (location.y>height-30) ) {
      PVector myforce = seek(new PVector(width/2,height/2));
      applyForce(myforce);
    }
  }
  //randomly create a new Clone, mutate it's DNA and add it to the population
  void reproduce(){
    if (random(1) < reproduction_rate){
      Agent newAgent = new Agent(location.get(), dna.getDNA());
      newAgent.dna.mutate();
      pop.addAgent(newAgent);
    }
  }
// Seek the closest food that is in this agent's range, if the food/poison is close enough (distance<maxspeed(in pixels)) remove the "eaten" food/poison from the enviroment arrays and apply the nutrition value to this agent.
  PVector eat(ArrayList<PVector> list, float nutrition, float perception) {
    float record = Float.POSITIVE_INFINITY;
    PVector closest = null;
    for (int i = list.size() - 1; i >= 0; i--) {
      float d = location.dist(list.get(i));

      if (d < dna.speed) {
        list.remove(i);
        health += nutrition;
        // maximum health is always 1
        if (health>1){
          health = 1 ;
        }
      } else {
        if (d < record && d < perception) {
          record = d;
          closest = list.get(i);
        }
      }
    }
    if (closest != null) {
      return seek(closest);
    }
    return new PVector(0,0);
  }

  // Get the steering and separation forces and apply them to this Agent
  void behaviors() {
      PVector steerF = eat(env.food, foodNutrition, dna.fPerception);
      PVector steerP = eat(env.poison,poisonNutrition, dna.pPerception);
      PVector separateForce = separate();
      separateForce.setMag(dna.separationForce);
      steerF.setMag(dna.fForce);
      steerP.setMag(dna.pForce);
      applyForce(separateForce);
      applyForce(steerF);
      applyForce(steerP);
    }
// Calculate and return the separation Force according to this Agent's Desired separation distance and separation Force
PVector separate () {
    float  desiredseparation = dna.desiredSeparation;
    PVector sum = new PVector();
    int count = 0;
    // For every agent in the system check if it is  too close
    for (Agent other : pop.population) {
      float d = PVector.dist(location, other.location);
      // If the distance is less than the desired amount
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate a vector pointing away from the neighbour
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average
    if (count > 0) {
      sum.div(count);
      //desired vector is the average scaled to the speed of the agent
      sum.normalize();
      sum.mult(dna.speed);
      sum.sub(velocity);
    }
    return sum;
  }

}
