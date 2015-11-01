include<stdio.h>
#include<stdlib.h>
#define null 100
#define nodes 10

int no;

struct node
 {
  int a[nodes][4];
 }router[nodes];


init(int r)
 {
  int i;
  
  for(i=1;i<=no;i++)
   {
   router[r].a[i][1]=i;
   router[r].a[i][2]=999;
   router[r].a[i][3]=null;
   }
  router[r].a[r][2]=0;
  router[r].a[r][3]=r;
