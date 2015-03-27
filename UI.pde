class UI {
  StringList classes;

  int startX = 10;
  int startY = 10;
  int w = 120;
  int h = 170;
  int spacing = 30;

  UI()
  {
    classes = new StringList();
    populate(); // populate classes
  }

  int getHighlighted () {
    int val = -1;
    if (mouseX < 100) {
      val =  min(23, int( (mouseY -15) / 30));//(height/25)  ));
    }
    return val;
  }

  void display() {

    if ( getHighlighted() == -1)
      highlighted = "Media Lab";
    else
      highlighted = classes.get(getHighlighted());


    rectMode(CORNERS);
    textAlign(RIGHT, BASELINE);

    stroke(0);
    strokeWeight(1);

    line(105, 0, 105, height);

    pushMatrix();
    translate(10, height/25);

    for (int i=0; i<classes.size()-1; i++) {
      fill(0);

      if ( getHighlighted() == i )
      {    
        rect(-5, -16, 95, 8);
        fill(360);
      }

      textFont(medium);
      text(classes.get(i), 85, 0);
      translate(0, spacing);
    }

    fill(0);
    popMatrix();
    textAlign(CENTER, TOP);
  }

  void populate() {
    classes.append("maold");
    classes.append("ma04");
    classes.append("ma05");
    classes.append("ma06");
    classes.append("ma07");
    classes.append("ma08");
    classes.append("ma09");
    classes.append("ma10");
    classes.append("ma11");
    classes.append("ma12");
    classes.append("ma13");
    classes.append("soundma08");
    classes.append("soundma09");
    classes.append("soundma11");
    classes.append("soundma12");
    classes.append("soundma13");
    classes.append("gamesma10");
    classes.append("gamesma12");
    classes.append("gamesma13");
    classes.append("research");
    classes.append("doctor");
    classes.append("doctoral");
    classes.append("faculty");
    classes.append("administrative");
  }

  void displayHeadline() {

    textAlign(LEFT, TOP);

    fill(0);
    textFont(headline);
    text("What " + highlighted + " does.", 125, 15);
  }
}

