 set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red


set ntrace [open prg6.tr w]
$ns trace-all $ntrace

set namfile [open prg6.nam w]
$ns namtrace-all $namfile


proc finish { } {
		global ns ntrace namfile
			
			$ns flush-trace
			close $ntrace
			close $namfile

		exec nam prg6.nam &
		exec cat prg6.tr | awk -f prg6.awk &
		exit 0
	}


    for { set i 0 } {$i < 6 } { incr i } {
		set n($i) [$ns node]
	}


      $n(0) label "TCP1"
      $n(4) label "SINK1"

      $n(5) label "TCP2"
      $n(1) label "SINK2"			


	$ns duplex-link $n(0) $n(2) 2Mb 10ms DropTail
	$ns duplex-link $n(1) $n(2) 2Mb 10ms DropTail
	$ns duplex-link $n(2) $n(3) 0.2Mb 100ms DropTail


#	set lan0 [$ns newLan "$n(3) $n(4) $n(5)" 0.5Mb 40ms LL Queue/DropTail MAC/802_3 Channel]


       $ns make-lan -trace on "$n(3) $n(4) $n(5)"    0.5Mb 40ms LL Queue/DropTail Mac/802_3 

	$ns duplex-link-op $n(0) $n(2) orient right-down
	$ns duplex-link-op $n(1) $n(2) orient right-up
	$ns duplex-link-op $n(2) $n(3) orient right


$ns queue-limit $n(2) $n(3) 20


 set tcp0 [new Agent/TCP]
$ns attach-agent $n(0) $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n(4) $sink0

$ns connect $tcp0 $sink0

$tcp0 set fid_ 1

$tcp0 set window_  8000
$tcp0 set packetSize_  1000


set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP


set tcp1 [new Agent/TCP]
$ns attach-agent $n(5) $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n(1) $sink1

$ns connect $tcp1 $sink1

$tcp1 set fid_ 2
$tcp1 set window_ 8000
$tcp1 set packetSize_ 1000

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

$ftp1 set type_ FTP


$ns at 0.1 "$ftp0 start"
$ns at 0.2 "$ftp1 start"
$ns at 24.8 "$ftp0 stop"
$ns at 24.9 "$ftp1 stop"
$ns at 25.0 "finish"


$ns run 
 
		
