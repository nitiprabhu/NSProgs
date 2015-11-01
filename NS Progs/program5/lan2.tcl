 set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red


set ntrace [open prg5.tr w]
$ns trace-all $ntrace

set namfile [open prg5.nam w]
$ns namtrace-all $namfile


proc finish { } {
		global ns ntrace namfile
			
			$ns flush-trace
			close $ntrace
			close $namfile

		exec nam prg5.nam &
		exec cat prg5.tr | awk -f prg5.awk &
		
		exit 0
	}


    for { set i 0 } {$i < 6 } { incr i } {
		set n($i) [$ns node]
	}


	$ns duplex-link $n(0) $n(2) 2Mb 10ms DropTail
	$ns duplex-link $n(1) $n(2) 2Mb 10ms DropTail
	$ns duplex-link $n(2) $n(3) 0.2Mb 100ms DropTail


#	set lan0 [$ns newLan "$n(3) $n(4) $n(5)" 0.5Mb 40ms LL Queue/DropTail MAC/802_3 Channel]


       $ns make-lan -trace on "$n(3) $n(4) $n(5)"  0.5Mb 40ms LL Queue/DropTail Mac/802_3 

	$ns duplex-link-op $n(0) $n(2) orient right-down
	$ns duplex-link-op $n(1) $n(2) orient right-up
	$ns duplex-link-op $n(2) $n(3) orient right


$ns queue-limit $n(2) $n(3) 10


#	set loss_module [new ErrorModel]
#	$loss_module ranvar [new RandomVariable/Uniform]
#	$loss_module drop-target [new Agent/Null]
#	$ns lossmodel $loss_module $n(2) $n(3) 


set err [new ErrorModel]
$ns lossmodel $err $n(2) $n(3)
$err set rate_ 0.1

$n(0) label "UDP"
$n(4) label "DEST_UDP"
$n(3) label "ERROR NODE "



set udp [new Agent/UDP]
$ns attach-agent $n(0) $udp

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

set null4 [new Agent/Null]
$ns attach-agent $n(4) $null4


$ns connect $udp $null4

$cbr set packetSize_ 4000
$cbr set interval_ 0.04


$udp set class_ 1




$ns at 0.04 "$cbr start"
$ns at 24.8 "$cbr stop"
$ns at 25.0 "finish"


$ns run 
 
		
