set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red


set ntrace [open prg7.tr w]
$ns trace-all $ntrace

set namfile [open prg7.nam w]
$ns namtrace-all $namfile



proc finish { } {
		global ns ntrace namfile
			
			$ns flush-trace
			close $ntrace
			close $namfile

		exec nam prg7.nam &
		exec cat prg7.tr | awk -f prg7.awk &
		exit 0
	}

    for {set i 0} {$i < 6} {incr i} {
		set n($i) [$ns node]
	}


	$ns duplex-link $n(0) $n(2) 10Mb 10ms DropTail
	$ns duplex-link $n(1) $n(2) 10Mb 10ms DropTail
	$ns duplex-link $n(2) $n(3) 0.5Mb 100ms DropTail


#	set lan0 [$ns newLan "$n(3) $n(4) $n(5)" 10Mb 10ms LL Queue/DropTail MAC/802_3 Channel]


       $ns make-lan  "$n(3) $n(4) $n(5)"  10Mb 10ms LL Queue/DropTail Mac/802_3 

	$ns duplex-link-op $n(0) $n(2) orient right-down
	$ns duplex-link-op $n(1) $n(2) orient right-up
	$ns duplex-link-op $n(2) $n(3) orient right


$ns queue-limit $n(2) $n(3) 20




set tcp0 [new Agent/TCP]
$tcp0 set fid_ 1
$ns attach-agent $n(0) $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n(4) $sink0

$ns connect $tcp0 $sink0
		


set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP  


set file1 [open file1.tr w]
$tcp0 attach $file1
$tcp0 trace cwnd_

$tcp0 set maxcwnd_ 10  


set tcp1 [new Agent/TCP]
$tcp1 set fid_ 2


$ns attach-agent $n(5) $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n(1) $sink1

$ns connect $tcp1 $sink1
		


set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP  


set file2 [open file2.tr w]
$tcp1 attach $file2
$tcp1 trace cwnd_

 $tcp1 set maxcwnd_ 5 

$ns at 0.1 "$ftp0 start"
$ns at 1.5 "$ftp0 stop"


$ns at 2 "$ftp0 start"
$ns at 3.4 "$ftp0 stop"

$ns at 0.2 "$ftp1 start"
$ns at 2 "$ftp1 stop"

#$ns at 2.5 "$ftp1 start"
#$ns at 3.3 "$ftp1 stop"

$ns at 3.5 "finish"

$ns run
