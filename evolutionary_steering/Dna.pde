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
  // Mutate an Agent's DNA to some value close to the original
  void mutate(){
    fPerception = change_constrain(fPerception,perceptionChange,0,maxPerception);
    pPerception = change_constrain(pPerception,perceptionChange,0,maxPerception);
    fForce = change_constrain(fForce,forceChange,-maxforce,maxforce);
    pForce = change_constrain(pForce,forceChange,-maxforce,maxforce);
    speed = change_constrain(speed,speedChange,0.01,maxspeed);
    desiredSeparation = change_constrain(desiredSeparation,perceptionChange,0,maxPerception);
    separationForce = change_constrain(separationForce,forceChange,-maxforce,maxforce);
}
float change_constrain(float value, float change , float min , float max){
    if (random(1)<mr){
      value += change;
      value = constrain(value,min,max);
  }
  return value;
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
