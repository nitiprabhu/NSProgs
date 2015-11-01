BEGIN {
	count=0;
	time=0;
}
{
	if ( $1 == "r" && $3 == 2  && $4 == 3)
	{
			count += $6;
			time=$2;
	}
}
END {

	printf("\n %d\t%lf",count,time); 
	printf("\n throughput : %lf  Mbps \n\n", (count/time) * (8/1000000) );
} 
