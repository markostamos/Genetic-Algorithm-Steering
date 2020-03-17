class Dna{
  float fPerception;
  float pPerception;
  float fForce;
  float pForce;
  float perceptionChange;
  float forceChange;
  float speed;
  float speedChange;
  float desiredSeparation;
  float separationForce;


  Dna(){
    desiredSeparation = random(1,maxPerception);
    fPerception = random(1,maxPerception);
    pPerception = random(1,maxPerception);
    fForce = random(-maxforce,maxforce);
    pForce = random(-maxforce,maxforce);
    speed = random(0,maxspeed);
    separationForce = random(-maxforce,maxforce);
    perceptionChange = mutation_weight * maxPerception;
    forceChange = mutation_weight * maxforce;
    speedChange = mutation_weight * maxspeed;
  }
  
  float randomize_and_limit(float current,float change,float min_bound,float max_bound){
    if (random(1) < mr) {
      current  +=random(-change,change);
      current = constrain(current, min_bound, max_bound);
      }
  }
  
  // Mutate an Agent's DNA to some value close to the original
  void mutate(){
    fPerception=randomize_and_limit(fPerception,perceptionChange,0,maxPerception);
    pPerception=randomize_and_limit(pPerception,perceptionChange,0,maxPerception);
    fForce=randomize_and_limit(fForce,forceChange,-maxforce,maxforce);
    pForce=randomize_and_limit(pForce,forceChange,-maxforce,maxforce);
    speed=randomize_and_limit(speed,speedChange,0.01,maxspeed);
    desiredSeparation=randomize_and_limit(desiredSeparation,perceptionChange,0,maxPerception);
    separationForce=randomize_and_limit(separationForce,forceChange,-maxforce,maxforce);
  }
    
}
  Dna getDNA(){
      Dna newDNA = new Dna();
      newDNA.fPerception = fPerception;
      newDNA.pPerception = pPerception;
      newDNA.fForce = fForce;
      newDNA.pForce =pForce;
      newDNA.speed = speed;
      newDNA.desiredSeparation = desiredSeparation;
      newDNA.separationForce = separationForce;
      return newDNA;
  }
}
