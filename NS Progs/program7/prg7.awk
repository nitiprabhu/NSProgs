BEGIN {
}

{
	if($6 == "cwnd_")
		printf("\n %f  %f",$1,$7);
}
END {
	puts "DONE"
}		
