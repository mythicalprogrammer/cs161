#include "cache.h"
#include <math.h>

using namespace std;

cache::cache (unsigned size, unsigned assoc, unsigned linesize)
{
   index = size / (assoc*linesize);
   cache_mem = new cache_v[index*assoc];
   this->assoc = assoc;
   hit = 0;
   miss = 0;
   line = linesize;

   for(int i = 0; i < (int)(index*assoc); ++i)
   {
     cache_mem[i].valid = false;
     cache_mem[i].tag = -1;
     cache_mem[i].lru = 0;
   }

}

void cache::read (unsigned address)
{
  //int offset_value = address % line;
   int index_value = (address >> (int)log2(line)) % index;
   int tag_value = address >> ((int)log2(line) + (int)log2(index));
   
   bool found = false;
   int InvalidIndex = -1;
 
 
   for(int i = index_value; i < (index*assoc); i += index)
   {
      if(cache_mem[i].tag == tag_value)
	{
	  found = true;
	  ++hit;
	  cache_mem[i].valid = false;
	  int max_update = cache_mem[i].lru;
	  cache_mem[i].lru = 1;
	  for(int y = index_value; y < (assoc*index); y += index){ // update LRU
	    if( cache_mem[y].valid == true && cache_mem[y].lru < max_update){
	      cache_mem[y].lru += 1;
	    }
	  }
	  cache_mem[i].valid = true;
	  break;
	}
      
      if(cache_mem[i].valid == false)
	{InvalidIndex = i;}
	

   }

/*
  int theGreatLRU = 0;
   for(int i = index_value; i < (index*assoc); i += index)
   {
     if(theGreatLRU < cache_mem[i].lru){
       theGreatLRU = cache_mem[i].lru;
     }	
   }*/


   if(found == false)
   {
     ++miss;
     
     if(InvalidIndex > -1) // line is not full
     {
       cache_mem[InvalidIndex].tag = tag_value;
       cache_mem[InvalidIndex].lru = 1;
       for(int i = index_value; i < (assoc*index); i += index){ // update LRU
	 if(cache_mem[i].valid == true){
	   cache_mem[i].lru += 1;
	 }
       }
       cache_mem[InvalidIndex].valid = true; 
     }      
     else if (InvalidIndex == -1) // line is full, must kick out the least used
     {
       int to_be_kicked;
       for(int i = index_value; i < (index*assoc); i += index)
       {
	 if(cache_mem[i].lru == assoc){ // kicking value (the bully system)
	   to_be_kicked = i;
	   cache_mem[to_be_kicked].tag = tag_value;
	   cache_mem[to_be_kicked].lru = 1;  
	 }
       }
       cache_mem[to_be_kicked].valid = false;
       for(int i = index_value; i < (assoc*index); i += index){ // update LRU
	 if(cache_mem[i].valid == true){
	   cache_mem[i].lru += 1;
	 }
       }
       cache_mem[to_be_kicked].valid = true;
     }
   }
}

void cache::stat (unsigned& num_hit, unsigned& num_miss)
{
  num_hit = hit;
  num_miss = miss;
}
