#include<stdio.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<sys/socket.h>
#include<netdb.h>
#include<stdlib.h>
#include<string.h>


int main(int argc,char *argv[])
{



  int sockfd,newsockfd,portno,len,n;
  char buffer[256],c[2000],cc[20000];
  struct sockaddr_in serv,cli;
  FILE *fd;


//here:
//while(1){

//here: 
  if(argc<2)
   {
     printf("erroe:no port no\n usage:\n/server port no\n");
     exit(1);
   }
  
  sockfd=socket(AF_INET,SOCK_STREAM,0);
   portno=atoi(argv[1]);
   serv.sin_family=AF_INET;
    serv.sin_addr.s_addr=INADDR_ANY;
   serv.sin_port=htons(portno);

   bind(sockfd,(struct sockaddr *)&serv,sizeof(serv));
   listen(sockfd,10);
  while(1)
  {
   len=sizeof(cli);

  printf("serve:\nwaiting for connection\n");
  newsockfd=accept(sockfd,(struct sockaddr *)&cli,&len);
    bzero(buffer,255);
  n=read(newsockfd,buffer,255);

 printf("\nserver recv:%s\n",buffer);

 if((fd=fopen(buffer,"r"))!=NULL)
 {
   printf("server:%s found\n opening and reading..\n",buffer);
   printf("reading..\n..reading complete");
   fgets(cc,2000,fd);

   while(!feof(fd))
   {   
    fgets(c,2000,fd);
    strcat(cc,c);
   }

   n=write(newsockfd,cc,strlen(cc));
     if(n<0)
 printf("error writing to socket");
  printf("\ntransfer complete\n");
  }

else
{
printf("server:file not found\n");
n=write(newsockfd,"file not foung",15);
if(n<0)
printf("error: writing to socket..\n");
}

//goto here;
}
}
