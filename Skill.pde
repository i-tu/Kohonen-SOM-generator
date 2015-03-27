class Skill
{
  String name;
  PVector scr;  // actual coordinates on screen
  int randX, randY;

  HeatMap hmap;

  int fontSize; // 0, 1, 2

  int n;

  Skill(int n_, String name_) {
    n = n_;
    name = name_;

    scr = new PVector(0, 0);
    randX = int(random(-10, 10));
    randY = int(random(-10, 10));

  }

  void init() {
    findPlaceOnMap();
    hmap = new HeatMap(n);
  }


  boolean inside() {
    if (dist(scr.x + 5, scr.y + 10, mouseX, mouseY) < 10)
      return true;
    else
      return false;
  }

  void displayHeatMap(){
    hmap.display();
    println(name);
  }

  // Display point in relation to selected origo.
  void display() {
    if ( n < INPUTDIMENSIONS/4 )   
      textFont(big);
    else if (n < INPUTDIMENSIONS/2)
      textFont(medium);
    else
      textFont(small);

    strokeText(name, int(scr.x + randX), int(scr.y + randY))  ;

    rectMode(CENTER);
  }

  void findPlaceOnMap() {
    scr = cToV(som.bestMatch( unitVecs[n] ));
    scr.mult(pixPerNode);
    scr.add( new PVector(SOM_X_DISPLACE, SOM_Y_DISPLACE) );
  }

  JSONObject export(){

    JSONObject json = new JSONObject();
    json.setString("name", name);
    json.setInt("x", int(scr.x));
    json.setInt("y", int(scr.y));
    json.setString("heatmap", hmap.export());
    json.setInt("id", n);
    return json;
  }


}

