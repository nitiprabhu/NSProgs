set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green
$ns color 4 orange


	set nt [open prgping.tr w]
	$ns trace-all $nt

	set nm [open prgping.nam w]
	$ns namtrace-all $nm

	proc finish { } {
	     global ns nt nm 
	     $ns flush-trace
	     close $nt
	     close $nm
	     exec nam prgping.nam &
	     exec cat prgping.tr | awk -f pingtest.awk &
	}


		for { set i 0 } { $i < 6 } {incr i } {
		set n($i) [$ns node]
		}

		for { set j 0 } { $j < 5 } {incr j } {
		$ns duplex-link $n($j) $n([expr $j + 1]) 0.1Mb 50ms DropTail
		}


		$ns duplex-link-op $n(0) $n(1) orient right-up
		$ns duplex-link-op $n(1) $n(2) orient right-down
		$ns duplex-link-op $n(2) $n(3) orient right-up
		$ns duplex-link-op $n(3) $n(4) orient right-down
		$ns duplex-link-op $n(4) $n(5) orient right-up


		Agent/Ping instproc recv {from rtt} {
	#	$self instvar node_

	#	puts "node [$node_ id] received ping answer from $from with round trip time $rtt ms"
	}


	$n(0) label "ping0"
	$n(2) label "tcp0_source"
	$n(4) label "tcp0_destination"
	$n(5) label "ping5"
	$n(3) label "tcp1_source"
	$n(1) label "tcp1_destination"

	set p0 [new Agent/Ping]
	$ns attach-agent $n(0) $p0


	set p1 [new Agent/Ping]
	$ns attach-agent $n(5) $p1

	$ns connect $p0 $p1


	$ns queue-limit $n(2) $n(3) 2
	$ns queue-limit $n(3) $n(2) 2
	$ns duplex-link-op $n(2) $n(3) queuePos 0.5
	$ns queue-limit $n(3) $n(4) 2
	$ns queue-limit $n(4) $n(3) 2
	$ns duplex-link-op $n(3) $n(4) queuePos 0.5

	set tcp0 [new Agent/TCP]
	$ns attach-agent $n(2) $tcp0

	set sink0 [new Agent/TCPSink]
	$ns attach-agent $n(4) $sink0
	$ns connect $tcp0 $sink0

	set cbr0 [new Application/Traffic/CBR]
	$cbr0 set packetSize_  1000
	$cbr0 set interval_ 0.0001
	$cbr0 attach-agent $tcp0

	set tcp1 [new Agent/TCP]
	$ns attach-agent $n(3) $tcp1

	set sink1 [new Agent/TCPSink]
	$ns attach-agent $n(1) $sink1
	$ns connect $tcp1 $sink1

	set cbr1 [new Application/Traffic/CBR]
	$cbr1 set packetSize_  1000
	$cbr1 set interval_ 0.0001
	$cbr1 attach-agent $tcp1

        $p0 set fid_ 1
	$p1 set fid_ 2
	$tcp0 set fid_ 3
	$tcp1 set fid_ 4

	$ns at 0.1 "$p0  send"
	$ns at 0.2 "$p0  send"
	$ns at 0.3 "$p0  send"
	$ns at 0.4 "$p0  send"
	$ns at 0.5 "$p0  send"
	$ns at 0.4 "$cbr0 start"
	$ns at 0.2 "$cbr1 start"
	$ns at 0.6 "$p0 send"
	
	$ns at 0.6.05 "$p0 send"
	$ns at 0.6.08 "$p0 send"
	$ns at 0.6.11 "$p0 send"
	$ns at 0.6.13 "$p0 send"
	$ns at 0.6.16 "$p0 send"
	$ns at 0.6.19 "$p0 send"

	$ns at 0.7 "$p0 send"
	$ns at 0.8 "$p0 send"
	$ns at 0.3 "$p0 send"

#	 $ns  rtmodel-at 0.8 down $n(2) $n(3)

	$ns at 1.1 "$p0 send"
	$ns at 1.2 "$p0 send"
	$ns at 1.3 "$p0 send"
	
	
#	$ns rtmodel-at 2.0 up $n(2) $n(3)
 
         $ns at 2.0 "$p0 send"
	$ns at 2.1 "$p0 send"
	$ns at 2.2 "$p0 send"
	$ns at 2.3 "$p0 send"
	$ns at 2.4 "$p0 send"
	$ns at 2.5 "$p0 send"
	$ns at 2.6 "$p0 send"

	$ns at 2.7 "$cbr0 stop"
	$ns at 2.9 "$cbr1 stop"

	$ns at 2.8 "finish"

	$ns run	

 
