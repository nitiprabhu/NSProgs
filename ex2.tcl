set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red

set nf [open lab2.nam w]
$ns namtrace-all $nf

set nt [open lab2.tr w]
$ns trace-all $nt

proc finish { } {

	global ns nf nt
	$ns flush-trace

	close $nf
	close $nt

	exec nam lab2.nam &

	exit 0
}
	
set n0 [ $ns node]
set n1 [ $ns node]
set n2 [ $ns node]
set n3 [ $ns node]

$n0 label "source1"
$n1 label  "source2"
$n3 label "Destination"  

$ns duplex-link $n0 $n2 10Mb 10ms DropTail
$ns duplex-link $n1 $n2 50Mb 15ms DropTail
$ns duplex-link $n2 $n3 1Mb 20ms DropTail

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right

set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0

set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

set tcp0 [ new Agent/TCP]
$ns attach-agent $n0 $tcp0

set tcpsink0 [ new Agent/TCPSink]
$ns attach-agent $n3 $tcpsink0

$ns set queue-limit $n0 $n2 1
$ns set queue-limit $n1 $n2 1
$ns set queue-limit $n2 $n3 1

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 2000
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $tcp0

$ns connect $udp0 $null0
$udp0 set fid_ 1
$ns connect $tcp0 $tcpsink0
$tcp0 set fid_ 2

$ns at 0.1 "$cbr0 start"
$ns at 0.2 "$cbr1 start"
$ns at 2.5 "$cbr0 stop"
$ns at 2.8 "$cbr1 stop"

$ns at 3.0 "finish"
 
$ns run
