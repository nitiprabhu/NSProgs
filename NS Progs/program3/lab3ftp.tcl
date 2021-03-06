set ns [new Simulator]

set nf [open lab3ftp.nam w]
$ns namtrace-all $nf

set nt [open lab3ftp.tr w]
$ns trace-all $nt

$ns color 1 Red
$ns color 2 Blue


proc finish { } {

	global ns nf nt
	$ns flush-trace

	close $nf
	close $nt

	exec nam lab3ftp.nam &
	exec cat lab3ftp.tr | awk -f lab3ftp.awk &

	exit 0
}
	
set n0 [ $ns node]
set n1 [ $ns node]
set n2 [ $ns node ]
set n3 [ $ns node ]

$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right


$ns set queue-limit $n0 $n2 10
 
$n0 label "FTP Source"
$n1 label "TELNET source"

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set tcp01 [new Agent/TCPSink]
$ns attach-agent $n3 $tcp01

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_  FTP
$ftp0 set interval_ 0.1
$ftp0 set packetSize_ 1000
$ns connect  $tcp0 $tcp01

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1

set tcp11 [new Agent/TCPSink]
$ns attach-agent $n3 $tcp11

set ftp1 [new Application/Telnet]
$ftp1 attach-agent  $tcp1
$ftp1 set type_ Telnet
$ftp1 set interval_ 0.1
$ftp1 set packetSize_ 1000
$ns connect  $tcp1  $tcp11


$tcp0 set fid_ 1
$tcp1 set fid_ 2


$ns at 0.1 "$ftp1 start"
$ns at 0.1 "$ftp0 start"

$ns at 24.0 "$ftp1 stop"
$ns at 24.5 "$ftp0 stop" 






$ns at 30.0 "finish"

$ns run
