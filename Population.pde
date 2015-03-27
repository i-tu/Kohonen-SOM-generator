class Population
{
  Major[] majors;

  Population() {
    majors = new Major[24];
    populate();
  }

  void init() {
    for (Major major : majors)
      major.init();
  }

  void display(int hi) {

    if ( hi == -1 ) {
      for (Major major : majors) {
        major.display();
      }
    }
    else {
      majors[hi].display();
      majors[hi].sudoDisplayConnections();
    }
  }

  JSONArray exportStudents() {
    JSONArray json = new JSONArray();

    for(Major major : majors)
      for(Student student : major.students)
        json.append( student.export() );

    return json;
  }

  JSONArray exportMajors() {
    JSONArray json = new JSONArray();

    for(Major major : majors)
        json.append( major.export() );

    return json;
  }

  void displayConnections() {
    for (Major major : majors)
      major.displayConnections();
  }

  void findConnections() {
    for (Major major : majors)
      major.findConnections();
  }

  void shout() {
    majors[15].shout();
  }

  void populate() {
    majors[0]  = new Major(0, "maold");
    majors[1]  = new Major(1, "ma04");
    majors[2]  = new Major(2, "ma05");
    majors[3]  = new Major(3, "ma06");
    majors[4]  = new Major(4, "ma07");
    majors[5]  = new Major(5, "ma08");
    majors[6]  = new Major(6, "ma09");
    majors[7]  = new Major(7, "ma10");
    majors[8]  = new Major(8, "ma11");
    majors[9]  = new Major(9, "ma12");
    majors[10] = new Major(10, "ma13");
    majors[11] = new Major(11, "soundma08");
    majors[12] = new Major(12, "soundma09");
    majors[13] = new Major(13, "soundma11");
    majors[14] = new Major(14, "soundma12");
    majors[15] = new Major(15, "soundma13");
    majors[16] = new Major(16, "gamesma10");
    majors[17] = new Major(17, "gamesma12");
    majors[18] = new Major(18, "gamesma13");
    majors[19] = new Major(19, "research");
    majors[20] = new Major(20, "doctor");
    majors[21] = new Major(21, "doctoral");
    majors[22] = new Major(22, "faculty");
    majors[23] = new Major(23, "administrative");
  }
}

