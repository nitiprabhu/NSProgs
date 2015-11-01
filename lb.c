#include<stdio.h>
#include<time.h>
int min(int x,int y)
{
if(x<y)
return x;
else
return y;
}

int main()
{
int drop=0,mini,nsec,cap,count=0,i,inp,process,packet;
system("clear");
printf("enter the bucket size:");
scanf("%d",&cap);
printf("enter the leak rate:");
scanf("%d",&process);
printf("enter the no of seconds u want to simulate:");
scanf("%d",&nsec);
printf("enter the packet size\n");
scanf("%d",&packet);
inp=packet;
printf("\n second\t   packet released\t   leak rate\t   bucket size\t   drop\t\n");
printf("-------------------------------------------------------------------------\n");
for(i=0;i<nsec;i++)
{
count=count+inp;
if(count>cap)
{
drop=count-cap;
count=cap;
}
printf("%d",i+1);
printf("\t\t %d",inp);
mini=min(count,process);
printf("\t\t %d",mini);
count=count-mini;
printf("\t\t %d",count);
printf("\t\t %d\n",drop);
if(drop>0)
inp=inp/2;
else
{
if(inp<packet)
inp++;
}
drop=0;
sleep(1);
}
}

