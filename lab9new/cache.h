#ifndef CACHE_H
#define CACHE_H

using namespace std;

class cache
{

 public:
   cache (unsigned size, unsigned assoc, unsigned linesize);
   void read (unsigned address);
   void stat (unsigned& num_hit, unsigned& num_miss);

 private:
   typedef struct foo
   {
     bool valid;
     int lru;
     int tag;
   }cache_v;

   cache_v* cache_mem;
   int index;
   int assoc;
   unsigned hit;
   unsigned miss;
   int line;

};

#endif /* CACHE_H */
