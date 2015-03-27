class HeatMap {
    int skill;
    heatNode[][] nodes;
    float minim = 100;
    float maxim = -100;
    int h, w;

    String export(){
        String csv = new String();
        
        for (int i = 0; i < h; i++) {
          for (int j = 0; j < w; j++) {
            csv += str(int(nodes[i][j].w));
            csv += ((j+1)<w) ? ',' : ';';
          }
        }
        return csv;
    }

    HeatMap(int skill_){

        skill = skill_;

        w = int(SCREENW/pixPerNode);
        h = int(SCREENH/pixPerNode);

        nodes = new heatNode[h][w];
        for (int i = 0; i < h; i++) {
          for (int j = 0; j < w; j++) {
            float d = som.weight_distance(somNodes[i][j].w, unitVecs[skill]);

            maxim = max(maxim, d);
            minim = min(minim, d);
            nodes[i][j] = new heatNode(d);
          }
        }

        for (int i = 0; i < h; i++) {
          for (int j = 0; j < w; j++) {
            nodes[i][j].w = int(map(nodes[i][j].w, minim, maxim, heatmapColors.pixels.length-1, 0));

          }
        }
    }

    void display() {
        rectMode(CORNER);

        for (int i = 0; i < h; i++) {
            for (int j = 0; j < w; j++) {
                fill( heatmapColors.pixels[ int(nodes[i][j].w) ] );
                noStroke();
                rect(j*pixPerNode + SOM_X_DISPLACE, i*pixPerNode + SOM_Y_DISPLACE, pixPerNode, pixPerNode);
          }
        }
      }

}