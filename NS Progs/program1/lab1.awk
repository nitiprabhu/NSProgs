BEGIN {
	count=0;
	}

	{
		if ($1=="d")
			count++;
	}

END	{
		printf("\n dropped packets %d\n\n",count);
	}
	
