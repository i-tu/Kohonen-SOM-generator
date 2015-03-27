void createFonts() {
  caption = createFont("FrutigerLTStd-Light", 8);
  small = createFont("FrutigerLTStd-Light", 12);
  medium = createFont("FrutigerLTStd-Light", 16);
  big = createFont("FrutigerLTStd-Light", 20); 
  headline = createFont("FrutigerLTStd-Bold", 48);
}

FloatList genWeights() {
  int dim = INPUTDIMENSIONS;
  float pie = 1; // This will be divided
  float proportion;

  FloatList w = new FloatList();

  for (int j=0; j<dim-1; j++) {

    proportion = random(0, pie); // You can only have as much pie as there is left    
    w.append(proportion);
    pie -= proportion;
  }

  w.append(pie);
  w.shuffle();

  return w;
}

void clearScreen(int opacity){
      fill(360, opacity);
      rect(SOM_X_DISPLACE, SOM_Y_DISPLACE, width*2, height*2);
}

void initUnitVecs() {
  unitVecs = new FloatList[INPUTDIMENSIONS];
  for (int i=0; i<INPUTDIMENSIONS; i++) {
    unitVecs[i] = new FloatList();
    for (int j=0; j<INPUTDIMENSIONS; j++) {
      if (i == j)
        unitVecs[i].append(1);
      else
        unitVecs[i].append(0);
    }
  }
}

PVector cToV(int ndxComposite) {
  int y = ndxComposite >> 16;
  int x = ndxComposite & 0x0000FFFF;
  return new PVector(x, y);
}

void progressText(String message) {
  println(message);
  textFont(headline);
  background(360);
  text(message, width/2, height/2);
}

void loadVectors() {
  men = new PShape[24];

  men[0]  = loadShape("maold.svg");
  men[1]  = loadShape("ma04.svg");
  men[2]  = loadShape("ma05.svg");
  men[3]  = loadShape("ma06.svg");
  men[4]  = loadShape("ma07.svg");
  men[5]  = loadShape("ma08.svg");
  men[6]  = loadShape("ma09.svg");
  men[7]  = loadShape("ma10.svg");
  men[8]  = loadShape("ma11.svg");
  men[9]  = loadShape("ma12.svg");
  men[10] = loadShape("ma13.svg");
  men[11] = loadShape("soundma08.svg");
  men[12] = loadShape("soundma09.svg");
  men[13] = loadShape("soundma11.svg");
  men[14] = loadShape("soundma12.svg");
  men[15] = loadShape("soundma13.svg");
  men[16] = loadShape("gamesma10.svg");
  men[17] = loadShape("gamesma12.svg");
  men[18] = loadShape("gamesma13.svg");
  men[19] = loadShape("research.svg");
  men[20] = loadShape("doctor.svg");
  men[21] = loadShape("doctoral.svg");
  men[22] = loadShape("faculty.svg");
  men[23] = loadShape("administrative.svg");
}

void strokeText(String message, int x, int y) { 
  fill(360); 
  text(message, x-1, y); 
  text(message, x, y-1); 
  text(message, x+1, y); 
  text(message, x, y+1); 
  fill(0); 
  text(message, x, y);
} 

