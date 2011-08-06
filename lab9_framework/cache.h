#ifndef CACHE_H
#define CACHE_H

using namespace std;

class cache {
 public:
   cache (unsigned size, unsigned assoc, unsigned linesize);
   void read (unsigned address);
   void stat (unsigned& num_hit, unsigned& num_miss);
 private:
   typedef struct foo
   {
     bool valid;
     int lru;
     unsigned int tag;
   }cache_v; //why typedef?

   cache_v* cache_mem;
   unsigned index;
   unsigned assoc;
   unsigned hit_num;
   unsigned miss_num;
   unsigned line;
};


#endif /* CACHE_H */
