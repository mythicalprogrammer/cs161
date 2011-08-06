#include <iostream>
using namespace std;

#include "cache.h"

int main() {
  /* init */
  cache cache0(2048,4,16);
  unsigned num_hit, num_miss;
  FILE * fp = fopen("trace","r");
  if(!fp) {
    cout << "Error: cannot open trace file. "
	 << "Make sure it is in the current directory" << endl;
    return 1;
  }
  //FILE * fp2 = fopen("trace2","w");
  unsigned address;
  while(fscanf(fp,"%x",&address) != EOF) {
    cache0.read(address);
    //fprintf(fp2,"%08x\n",address);
  }
  fclose(fp);
  //fclose(fp2);
  cache0.stat(num_hit, num_miss);
  cout << "stat1: " << num_hit << " " << num_miss << endl;
  return 0;
} /* main */
