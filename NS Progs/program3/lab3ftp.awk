BEGIN {
	ftp=0; 
	time1=0;
	telnet=0;
	time2=0;
}
{
if( $3==0 && $4==2 && $5=="tcp")
{	ftp++;
	time1=$2;
}
if( $3==1 && $4==2 && $5=="tcp")
{	telnet++;
	time2=$2;
}
}
END {
	printf("through put of ftp=%lf Mbps \n",(ftp/time1)*(8/1000000));
	printf("through put of telnet=%lf Mbps \n",(telnet/time2)*(8/1000000));
}
