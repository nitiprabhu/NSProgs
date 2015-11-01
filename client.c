#include<stdio.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<netdb.h>
#include<stdlib.h>
#include<string.h>


int main(int argc,char *argv[])
 {
    int sockfd,newsockfd,portno,len,n;
    char buffer[256],c[20000];
    struct sockaddr_in serv,cli;
    FILE *fd;

    if(argc<2)
    {
       printf("Err:no port no.\nusage:\n./client portno\n                                                                                                                            ex:./client 7777\n");
      exit(1);
    }
 
   sockfd=socket(AF_INET,SOCK_STREAM,0);
   bzero((char *)&serv,sizeof(serv));

     portno=atoi(argv[1]);
     serv.sin_family=AF_INET;
     
    serv.sin_port=htons(portno);
     if(connect(sockfd,(struct sockaddr *)&serv,sizeof(serv))<0)
    {
      printf("server not responding..\n\n\n\ti am to terminate    \n");
      exit(1);
    }

     printf("Enter the file with complete path\n");
     scanf("%s",&buffer);    

    if(write(sockfd,buffer,strlen(buffer))<0)
    printf("Err writing to socket..\n");
     bzero(c,2000);
   printf("Reading..\n..\n");

   if(read(sockfd,c,1999)<0)
   printf("error: read error\n");
  printf("client: display content of %s\n..\n",buffer);
   fputs(c,stdout);
   printf("\n..\n");
   
    return 0;
}
