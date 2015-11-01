BEGIN{
  count1=0; 
  count2=0;
}

{


  if(($1 == "d") && ($3==3))
    count1++;

  if($1=="d" && $3==2 ) 
   count2++;
}

END{
  printf("\n total packets dropped\n From Node3 to Node1 is  %d \n From Node2 to Node4 is %d \n",count1, count2);
}
