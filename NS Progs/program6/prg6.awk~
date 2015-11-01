BEGIN {
		count4=0;
		count3=0;
		count5=0;
}
{
	if($1=="c" && $3==3){
			
			count3++;
		}
	if($1 == "c" && $3==4) {
			count4++;
		}

	if($1=="c" && $3==5) {
		couunt5++;
	}

}

END {
	printf("\n The total packet collision at node 3 is %d", count3);
	printf("\n the packet collision at node 4 is %d", count4);
	printf("\n packet collision at node 5 is %d\n\n", count5);
  }


