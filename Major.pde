class Major {

  String shortName;
  String longName;
  Student[] students;
  IntList w;
  int cat;

  Major(int cat_, String shortName_) {

    cat = cat_;
    shortName = shortName_;
    w = new IntList();

    // Count the amount of students in this major
    int count = 0;
    for (int i = 0; i < skillMatrix.length; i++) {
      if ( split(skillMatrix[i], ',')[0].equals(shortName) ) {
        count++;
      }
    }

    students = new Student[count];

    int index = 0;
    for (int i = 0; i < skillMatrix.length; i++) {

      String[] pieces = split(skillMatrix[i], ',');
      if ( pieces[0].equals(shortName) == false )
        continue;

      if (pieces.length < 10) {
        println("Problemo, Majore!");
        println(pieces);
      }

      students[index] = new Student(i, pieces);
      appendToWeights( pieces );

      index++;
    }

  }

  void appendToWeights(String[] pieces){

      for(int i = 1;i<pieces.length-1;i++){
        if( float(pieces[i]) != 0)
            w.set(i,1);
      }
  }
 
  JSONArray exportStudents(){
    JSONArray json = new JSONArray();

    for(Student student : students){
      JSONObject studentJSON = student.export();
      if(studentJSON != null)
        json.append(studentJSON);
    }
    return json;
  }

  JSONObject export(){
    JSONObject json = new JSONObject();
    json.setString("name", shortName);
    json.setJSONArray("skills", exportSkills());
    return json;
  }

  JSONArray exportSkills() {
    JSONArray json = new JSONArray();
    int i=0;
    int index=0;
    for(float skill : w.array()) {
      if(skill != 0){
        json.setInt(i, index);
        i++;
      }
      index++;

    }
    return json;
  }

  void init() {
    println("  init " + shortName);
    for (Student student : students)
      student.init();
  }

  void shout() {
    students[0].shout();
  }

  void display() {

    for (Student student : students) {
      student.display(cat);
    }
  }


  void displayConnections() {

    for (Student student : students) {
      student.displayConnections();
    }
  }

  void findConnections() {

    for (Student student : students) {
      student.findConnections();
    }
  }

  void sudoDisplayConnections() {

    for (Student student : students) {
      student.sudoDisplayConnections();
    }
  }
}

