color[] colorAssociations;

color getColorAssociation(String s) {

  colorMode(HSB, 360, 100, 100);

  if (s.equals("ma94"))
    return color(100, 40, 80);
  if (s.equals("ma95"))
    return color(100, 45, 80);
  if (s.equals("ma96"))
    return color(100, 50, 80);
  if (s.equals("ma97"))
    return color(100, 55, 80);
  if (s.equals("ma98"))
    return color(100, 60, 80);
  if (s.equals("ma99"))
    return color(100, 65, 80);
  if (s.equals("ma00"))
    return color(100, 70, 80);
  if (s.equals("ma01"))
    return color(100, 75, 80);
  if (s.equals("ma02"))
    return color(100, 80, 80);
  if (s.equals("ma03"))
    return color(100, 85, 80);
  if (s.equals("ma04"))
    return color(100, 90, 80);
  if (s.equals("ma05"))
    return color(100, 95, 80);
  if (s.equals("ma06"))
    return color(100, 100, 80);
  if (s.equals("ma07"))
    return color(100, 100, 85);
  if (s.equals("ma08"))
    return color(100, 100, 90);
  if (s.equals("ma09"))
    return color(100, 100, 95);
  if (s.equals("ma10"))
    return color(100, 100, 100);
  if (s.equals("ma11"))
    return color(100, 100, 100);
  if (s.equals("ma12"))
    return color(100, 100, 100);
  if (s.equals("ma13"))
    return color(100, 100, 100);

  if (s.equals("soundma08"))
    return color(130, 100, 90);
  if (s.equals("soundma09"))
    return color(130, 100, 95);
  if (s.equals("soundma10"))
    return color(130, 100, 100);
  if (s.equals("soundma11"))
    return color(130, 100, 100);
  if (s.equals("soundma12"))
    return color(130, 100, 100);
  if (s.equals("soundma13"))
    return color(130, 100, 100);

  if (s.equals("gamesma10"))
    return color(70, 100, 100);
  if (s.equals("gamesma11"))
    return color(70, 100, 100);
  if (s.equals("gamesma12"))
    return color(70, 100, 100);
  if (s.equals("gamesma13"))
    return color(70, 100, 100);

  if (s.equals("alumni"))
    return color(100, 40, 40);

  if (s.equals("research") || s.equals("doctor") || s.equals("doctoral"))
    return color(30, 100, 100);

  if (s.equals("faculty"))
    return color(0, 100, 100);

  if (s.equals("administrative"))
    return color(0, 100, 50);

  else return color(255, 100, 100);
}

