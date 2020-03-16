class Population{
  ArrayList<Agent> population;

  Population(int size){
    population = new ArrayList<Agent>();
    for (int i = 0 ; i <size ; i++){
      Agent newAgent = new Agent(new PVector(random(width),random(height)), new Dna());
      population.add(newAgent);
    }
  }
  // Call the run function for all agents, if they are dead remove them
  void live(){
    for (int i = 0 ; i < population.size();i++){
      Agent thisAgent = population.get(i);
      if (thisAgent.isDead()) {
        if(dead_leave_food) env.addFood(thisAgent.location.copy());
      population.remove(i);
      continue;
      }
      thisAgent.run();
    }
  }
  void addAgent(Agent newAgent){
    population.add(newAgent);
  }
// calculate and show average dna
  void calculateAverage(){
    float pForces =0;
    float fForces =0;
    float pPerceptions = 0;
    float fPerceptions = 0;
    float speeds = 0;
    float separations = 0;
    float separationForces = 0;
    float popsize = population.size();
    for (Agent ag : population){
      pForces += ag.dna.pForce;
      fForces +=ag.dna.fForce;
      pPerceptions+= ag.dna.pPerception;
      fPerceptions+= ag.dna.fPerception;
      speeds += ag.dna.speed;
      separations+= ag.dna.desiredSeparation;
      separationForces += ag.dna.separationForce;
    }
    pForces = pForces / popsize;
    fForces = fForces / popsize;
    pPerceptions = pPerceptions / popsize;
    fPerceptions = fPerceptions / popsize;
    speeds = speeds/popsize;
    separations = separations/popsize;
    separationForces = separationForces / popsize;
    float pForcePercent = 100*(pForces/maxforce);
    float fForcePercent = 100*(fForces/maxforce);
    float pPerceptionPercent = 100*(pPerceptions/maxPerception);
    float fPerceptionPercent = 100*(fPerceptions/maxPerception);
    float speedPercent = 100*(speeds/maxspeed);
    float separationPercent = 100*(separations/maxPerception);
    float separationForcePercent = 100*(separationForces / maxforce);
    textSize(23);
    fill(255);

    text("Agents Alive: "+ str(floor(popsize)),8,20);
    text("Average speed: "+ str(floor(speedPercent)) +"%", 8,50);

    text("Attraction to: ",8,height-130);
    text("Food: " + str(floor(fForcePercent)) +"%", 8, height-90);
    text("Poison: "+ str(floor(pForcePercent)) +"%", 8, height-60);
    text("Other Agents: "+ str(floor(-separationForcePercent)) +"%", 8, height-30);

    text("Perception for: ",width-300,height-130);
    text("Food: "+ str(floor(fPerceptionPercent)) +"%" , width-300, height-90);
    text("Poison: "+ str(floor(pPerceptionPercent)) +"%", width-300, height-60);
    text("Other Agents: "+ str(floor(separationPercent)) +"%", width-300, height-30);

  }

}
