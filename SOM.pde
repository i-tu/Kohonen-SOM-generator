somNode[][] somNodes;
float maxim = 0;
float minim = 0;

class SOM
{
  int mapW, mapH;
  float radius;
  float timeConstant;
  float learnRate = learnDecay;
  int inputDimension;

  SOM(int h, int w, int n) {

    radiusDecay = (SCREENW/pixPerNode + SCREENH/pixPerNode) / 2;
    mapH = h;
    mapW = w;
    // radius = sqrt(h*h + w*w)/2;
    radius = mapW/2;
    inputDimension = n;

    somNodes = new somNode[h][w];

    for (int i = 0; i < h; i++) {
      for (int j = 0; j < w; j++) {
        somNodes[i][j] = new somNode();
      }
    }
    initTraining(MAXITERS);
  }

  void initTraining(int iterations) {
    timeConstant = iterations  /log(radius);
  }

  void train(int iter, int t) {
    som.train(iter, allWeights[t] );
  }

  void train(int i, FloatList w) {   
    radiusDecay = radius*exp(-1*float(i)/timeConstant);   /// SIGMA
    learnDecay = learnRate*exp(-1*float(i)/timeConstant);  // L

    //get best matching unit
    int ndxComposite = bestMatch(w);
    int y = ndxComposite >> 16;
    int x = ndxComposite & 0x0000FFFF;

    //scale best match and neighbors...
    for (int a = 0; a < mapH; a++) {  
      for (int b = 0; b < mapW; b++) {

        float d = dist(x, y, b, a);
        //float influence = exp((-1*sq(d)) / (2*sq(radiusDecay))); // NEIGHBOURHOOD FUNCTION THETA, originally         
        float influence = exp((-1*sq(d)) / (2*radiusDecay*i)); // Why the times i ???

        if (d < radiusDecay)
          for (int k = 0; k < inputDimension; k++) {
            somNodes[a][b].w.add(k, influence * learnDecay * (w.get(k) - somNodes[a][b].w.get(k) ));
          }
      }
    }
  }

  int bestMatch(FloatList w) {
    float minDist = sqrt(inputDimension);
    int minIndex = 0;

    for (int i = 0; i < mapH; i++) {
      for (int j = 0; j < mapW; j++) {
        float tmp = weight_distance(somNodes[i][j].w, w);
        if (tmp < minDist) {
          minDist = tmp;
          minIndex = (i << 16) + j;
        }
      }
    }

    // note this index is x << 16 + y. 
    return minIndex;
  }

  float weight_distance(FloatList x, FloatList y)  {
    if (x.size() != y.size()) {
      println ("Error in SOM::distance(): array lengths don't match");
      println(str(x.size()));
      println(str(y.size()));

      exit();
    }
    float tmp = 0.0;
    for (int i = 0; i < x.size(); i++)
      tmp += sq( (x.get(i) - y.get(i)));
    tmp = sqrt(tmp);
    return tmp;
  }
}

