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
    if (random(1) < mr) {
      fPerception  +=random(-perceptionChange,perceptionChange);
      fPerception = constrain(fPerception, 0, maxPerception);

    }
    if (random(1) < mr) {
      pPerception += random(-perceptionChange,perceptionChange);
      pPerception = constrain(pPerception, 0, maxPerception);

    }
    if (random(1) < mr) {
      fForce += random(-forceChange,forceChange);
      fForce = constrain(fForce, -maxforce, +maxforce);

    }
    if (random(1) < mr) {
      pForce += random(-forceChange,forceChange);
      pForce = constrain(pForce, -maxforce, +maxforce);

  }
  if (random(1) < mr) {
    speed += random(-speedChange,speedChange);
    speed = constrain(speed, 0.01, maxspeed);
}
if (random(1) < mr) {
  desiredSeparation += random(-perceptionChange,perceptionChange);
  desiredSeparation = constrain(desiredSeparation, 0, maxPerception);
}
if (random(1) < mr) {
  separationForce += random(-forceChange,forceChange);
  separationForce = constrain(separationForce, -maxforce, +maxforce);
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
