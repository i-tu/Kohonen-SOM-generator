/*
Media Lab Interest visualization
 Ian Tuomi 2013
 
 Data ripped from Media Lab intranet and processed with Python
 mlab.uiah.fi/people
 
 SOM Algorithm based on Jeffrey Guy's (buggy, albeit not advertised as stable) Processing implementation (http://www.jjguy.com/som/)
 ...which is based "in spirit" on Paras Chopra's python implementation (http://www.paraschopra.com/sourcecode/SOM/index.php)  
 
 This map is the result of a dimensionality reduction analysis on the
 profile information media lab students have posted of themselves online
 
 Hovering over a year highlights where specific students are situated on the map
 of skills.
 */

/*
Set in Frutiger.
 System names of weights:
 "FrutigerLTStd-Black"
 "FrutigerLTStd-BlackCn"
 "FrutigerLTStd-BlackItalic"
 "FrutigerLTStd-Bold"
 "FrutigerLTStd-BoldCn"
 "FrutigerLTStd-BoldItalic"
 "FrutigerLTStd-Cn"
 "FrutigerLTStd-ExtraBlackCn"
 "FrutigerLTStd-Italic"
 "FrutigerLTStd-Light"
 "FrutigerLTStd-LightCn"
 "FrutigerLTStd-LightItalic"
 "FrutigerLTStd-Roman"
 "FrutigerLTStd-UltraBlack"
 */

// -- User Interface -- //

// UI has everything to do with the controls
UI ui;

final int MAXITERS = 10;
int SCREENW = 1100;
int SCREENH = 730;

int SOM_X_DISPLACE = 180;
int SOM_Y_DISPLACE = 75;

int INPUTSIZE;
int INPUTDIMENSIONS;
  
String highlighted;

PFont caption;
PFont small;
PFont medium;
PFont big;
PFont headline;

PShape[] men;

// --- Global variables --- //

// MLab includes all major studies, which include Students
Population population;

// SOM includes all algorithmic heavy lifting
SOM som;
float learnDecay = 0.1;
float radiusDecay;
int pixPerNode = 30;

String[] names;

// Skills are reffered to 
Skill[] skills;

String[] categories;
String[] skillMatrix;
String selectedCategory;

FloatList[] unitVecs;
FloatList[] allWeights;

PImage heatmapColors;
// ---
void setup() {


  size(1335, 860);
  createFonts();
  progressText("Initial configuration..");

  textFont(medium);
  textAlign(LEFT, TOP);
  colorMode(HSB, 360);
  heatmapColors = loadImage("heatmapColors.png");
  heatmapColors.loadPixels();

  progressText("Reading input data...");

  categories = loadStrings("categories.txt");
  skillMatrix = loadStrings("skillmatrix.txt");
  names = loadStrings("names.txt");

  progressText("Master student skillmatrix...");

  INPUTSIZE = skillMatrix.length;
  INPUTDIMENSIONS = categories.length;

  initUnitVecs();

  allWeights = new FloatList[INPUTSIZE];

  for (int i = 0; i < skillMatrix.length; i++) {   
    FloatList w = new FloatList();
    String[] pieces = split(skillMatrix[i], ',');

    for (int j = 1; j < pieces.length -1; j++) {
      w.append( float(pieces[j]) );
    }

    allWeights[i] = w;
  }

  progressText("Master skill list");

  skills = new Skill[INPUTDIMENSIONS];
  for (int i = 0; i < INPUTDIMENSIONS; i++) {
    skills[i] = new Skill(i, categories[i].replace('_', ' ') );
  }


  progressText("Input data Valid:");
  progressText("  No. of Students: " + str(INPUTSIZE));
  progressText("  No. of unique skills: " + str(INPUTDIMENSIONS));

  progressText("Creating population...");
  population = new Population();

  progressText("Initializing SOM...");

  som = new SOM(int(SCREENH/pixPerNode), int(SCREENW/pixPerNode), INPUTDIMENSIONS);

  progressText("Training SOM...");

  for (int iter = 1; iter < MAXITERS; iter++) {
    som.train(iter, int(random(INPUTSIZE)) );
    if (iter % 500 == 0) {

      progressText(str(float(iter)/float(MAXITERS)));
    }
  }

  progressText("Initializing population");

  population.init();

  progressText("Loading vectors");

  loadVectors();
  progressText("Loading skills");

  for (Skill skill : skills)
      skill.init();

  progressText("Setting up UI");
  ui = new UI();

  progressText("Setup done.");

  noLoop();
}


void draw() {

  background(360);

  skills[int(random(100))].displayHeatMap();

  rectMode(CORNERS);

  int hi = ui.getHighlighted();

  /* FIRST DISPLAY ALL */
  // SOMEONE SPECIFIC IS TO BE DISPLAYED
  if (hi != -1) {

    population.display(-1);

    for (Skill skill : skills)
      skill.display();

//    clearScreen(250);

    population.display(hi);  
    population.displayConnections();
  }
  else { // EVERYONE OR GROUP TO BE DISPLAYED
    population.findConnections();
    population.display(-1);

    if ( highlighted.equals("Media Lab") ) {
//      clearScreen(50);
      for (Skill skill : skills)
        skill.display();
    }
    else { // EVERYONE GETS DISPLAYED

      for (Skill skill : skills)
        skill.display();

      population.displayConnections();
    }
  }
  ui.displayHeadline();
  ui.display();
}

void mouseClicked() {
  export();
  redraw();
}

void export() {
  JSONObject json = new JSONObject();
  json.setJSONArray("students", population.exportStudents() );  
  json.setJSONArray("skills", exportSkills());
  json.setJSONArray("classes", population.exportMajors() );
   
  saveJSONObject(json, "data.json");
}

JSONArray exportSkills(){
  JSONArray json = new JSONArray();
  for(Skill skill : skills)
    json.setJSONObject( skill.n, skill.export() );
  return json;
}
