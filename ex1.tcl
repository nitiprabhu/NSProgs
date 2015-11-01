set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red

set nf [open lab1.nam w]
$ns namtrace-all $nf

set nt [open lab1.tr w]
$ns trace-all $nt

proc finish { } {

	global ns nf nt
	$ns flush-trace

	close $nf
	close $nt

	exec nam lab1.nam &

	exit 0
}
	
set n0 [ $ns node]
set n1 [ $ns node]
set n2 [ $ns node]

$n0 label "source1"
$n1 label  "source2"  

$ns duplex-link $n0 $n2 1Mb 15ms DropTail
$ns duplex-link $n1 $n2 0.5Mb 15ms DropTail

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1

set null0 [new Agent/Null]
$ns attach-agent $n2 $null0

$ns set queue-limit $n0 $n2 1
$ns set queue-limit $n1 $n2  1

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 2000
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1

$ns connect $udp0 $null0
$udp0 set fid_ 1
$ns connect $udp1 $null0
$udp1 set fid_ 2

$ns at 0.1 "$cbr0 start"
$ns at 0.2 "$cbr1 start"
$ns at 2.5 "$cbr0 stop"
$ns at 2.8 "$cbr1 stop"

$ns at 3.0 "finish"

$ns run
