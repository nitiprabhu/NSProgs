BEGIN {
	count1=0 ;
        count2=0 ;
        count3=0 ;
        count4=0;
	}

	{
		if ($1=="r")
			count1++;
                if($1=="d")
                       count2++;
                if($1=="+")
                   count3++;
                if($1=="-")
                      count4++;
                 
	}

END	{
		printf("\n Receive packets %d\n Dropped Packets %d\n Entered Packets %d\n Exited Packed %d\n",count1, count2, count3, count4);
	}
