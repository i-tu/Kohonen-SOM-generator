class Student
{
  String category;

  int n;
  PVector scr;  // actual coordinates on screen
  int randX, randY;
  FloatList w;
  color myColor;
  int cat_;

  Student(int n_, String[] inputs) {
    n = n_;
    category = inputs[0];

    w = new FloatList();

    for (int i = 1; i < inputs.length - 1 ; i++) {
      w.append(float(inputs[i]));
    }

    scr = new PVector(0, 0);
    randX = int(random(-10, 10));
    randY = int(random(-10, 10));
  }

  void init() {
    findPlaceOnMap();
    findColor();
  }

  JSONArray exportSkills() {
    JSONArray json = new JSONArray();
    int i=0;
    int index=0;
    for(float skill : w.array()) {
      if(skill != 0){
        json.setFloat(i, index);
        i++;
      }
      index++;

    }
    return json;
  }

  JSONObject export() {
    JSONObject json = new JSONObject();
    json.setString("name", names[n]);
    json.setString("category", category);
    json.setInt("cat", cat_);
    json.setInt("n", n);
    json.setInt("x", int(scr.x));
    json.setInt("y", int(scr.y));
    json.setJSONArray("skills", exportSkills()); 
    return json;
  }

  void shout() {
    println("coordinates", scr.x, scr.y);
    /*    println("weights");
     println(w);    */
    displayConnections();
  }

  boolean inside() {

    if (dist(scr.x + randX, scr.y + randY, mouseX, mouseY) < 30)
      return true;
    else
      return false;
  }


  // Display point in relation to selected origo.
  void display(int cat) {
    cat_ = cat;
    fill(255);
    textSize(8);
    rectMode(CENTER);

    noStroke();
    tint(myColor);

    shape( men[cat], scr.x + randX, scr.y  + randY, 14, 45);

    //image(man, scr.x + randX, scr.y  + randY, 18, 30);

    //   ellipse(coordX+ int(random(-10,10)), coordY + int(random(-10,10)), 100,100);
    textSize(12);
  }

  void findConnections() {
    if (inside())
      highlighted = names[n];
  }

  void displayConnections() {
    if (!inside())
      return;

    highlighted = names[n];

    for (int i = 0; i<w.size(); i++) {
      if (w.get(i) == 0)
        continue;

      skills[i].display();
    }

    display(cat_);
  }

  void sudoDisplayConnections() {

    for (int i = 0; i<w.size(); i++) {
      if (w.get(i) == 0)
        continue;

      skills[i].display();
    }
  }

  void findPlaceOnMap() {
    scr = cToV(som.bestMatch(w));
    scr.mult(pixPerNode);
    scr.add( new PVector(SOM_X_DISPLACE, SOM_Y_DISPLACE) );
  }

  void findColor() {
    myColor = getColorAssociation(category);
  }
}

