BEGIN {
	count1=0 ;
        count2=0 ;
        count3=0 ;
        count4=0;
	}

	{
                  if($1=="r" && $3 ==1)
                       count1++;
                   if($1=="r" && $3==2)
                      count4++;
                 
	}

END	{
		printf("\n TCP %d\n UDP %d\n",count1, count4);
	}
