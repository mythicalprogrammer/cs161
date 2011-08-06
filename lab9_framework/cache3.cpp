
#include "cache.h"
#include <math.h>
#include <iostream>

using namespace std;

//668353
//343823


cache::cache (unsigned size, unsigned assoc_i, unsigned linesize)
{
  assoc = assoc_i;
  index = size / (assoc * linesize);
  cache_mem = new cache_v[index*assoc];
  hit_num = 0;
  miss_num = 0;
  line = linesize;
}

void cache::read (unsigned address)
{

  //unsigned int offset_value = address % linesize;
 unsigned int index_value = (address >> (unsigned int)log2(line)) % index;
 unsigned int tag_value = address >> ((unsigned int)log2(line) + (unsigned int)log2(index));

 //------------CHECK IF DATA IS IN CACHE------------//
 //-------------------------------------------------//
 int temp_lru = 0;
 bool found = false;
 unsigned int toBereplaceAdd = cache_mem[index_value].lru;
 //unsigned int block = 0;
 int firstInvalidBlck = -1; 

 for(unsigned int i = index_value; i < (index*assoc); i +=(index) )  //go to index 
   { 

     if(cache_mem[i].valid == true && (unsigned)cache_mem[i].tag == tag_value)
       {	
	 found = true; //hit
	 ++hit_num;

	 temp_lru = cache_mem[i].lru;
	 cache_mem[i].lru = 1;

	 for(unsigned int y = index_value; y < (index*assoc); y+=(index)) //update lru
	   {
	     if(cache_mem[y].lru <= (int)temp_lru && cache_mem[y].tag != (int)tag_value)
	       cache_mem[y].lru = cache_mem[y].lru + 1;       
	   } 

       }


     if((int)toBereplaceAdd < cache_mem[i].lru)
         {
	   toBereplaceAdd = i;
	   
	 }

     if(cache_mem[i].valid == false && firstInvalidBlck == -1)
       firstInvalidBlck = i;
     

     //++block;

   }// end for loop

 if(found == false)
   {
     ++miss_num;

     if(firstInvalidBlck == -1)
       {
	 cache_mem[toBereplaceAdd].valid = true;
	 cache_mem[toBereplaceAdd].lru = 1;     
	 cache_mem[toBereplaceAdd].tag = tag_value; 
	 
	 for(unsigned int z = (int)index_value; z < (index*assoc); z+=(index)) //update lru
	   {
	     if(cache_mem[z].lru <= (int)temp_lru && cache_mem[z].tag != (int)tag_value)
	       cache_mem[z].lru = cache_mem[z].lru + 1;       
	   } 
	 

       }
     else if(firstInvalidBlck != -1)
       {
	 cache_mem[firstInvalidBlck].valid = true;
	 cache_mem[firstInvalidBlck].lru = 1;    //update ranking     
	 cache_mem[firstInvalidBlck].tag = tag_value; 
	 
	 for(unsigned int a = (int)index_value; a < (index*assoc); a+=(index+1)) //update lru
	   {
	     if(cache_mem[a].lru <= (int)temp_lru && cache_mem[a].tag != (int)tag_value && cache_mem[a].valid != false)
	       cache_mem[a].lru = cache_mem[a].lru + 1;       
	   } 
	 
       }
   }
 
 
}

void cache::stat (unsigned& num_hit, unsigned& num_miss)
{
  num_hit = miss_num;

  num_miss = hit_num;
}
