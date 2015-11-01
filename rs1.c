#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
unsigned long modexp(unsigned long msg,unsigned long exp,unsigned long n)
{
       unsigned long i,k=1;
       for(i=0;i<exp;i++)
       k=(k*msg)%n;
       return k;
}
int main()
{
       unsigned long p,q,e,d,n,z,i,C,M;
       int len;
       char data[100];
       system("clear");
       printf("Enter the value of P and Q (such that p*q>255 and p not equal to q)\n");
       scanf("%lu%lu",&p,&q);
       n=p*q;
       z=(p-1)*(q-1);
       for(i=1;i<z;i++)
       {
                if((z%i)==0)
                continue;
                else
                break;
  }
  e=i;
  printf("\nEncryption key is :%lu",e);
  for(i=1;i<z;i++)
  if(((e*i-1)%z)==0)
  break;
  d=i;
  printf("\ndecryption key is :%lu",d);
  printf("\npls enter the message:");
  scanf("%s",data);
  len=strlen(data);
  for(i=0;i<len;i++)
  {
           M=(unsigned long)data[i];
           C=modexp(M,e,n);
           printf("\nencrypted value and its char representation:%lu\t%c\n",C,C);
           M=modexp(C,d,n);
           printf("\ndecrypted value and its char representation:%lu\t%c\n",M,M);
  }
  return 0;
}

