# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(stop)   10.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

#===================================
#        Nodes Definition        
#===================================
#Create 3 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

#===================================
#        Links Definition        
#===================================
#Createlinks between nodes
$ns duplex-link $n0 $n1 10Mb 10ms DropTail
$ns queue-limit $n0 $n1 5
$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns queue-limit $n1 $n2 2

#Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n1 $n2 orient right

#===================================
#        Agents Definition        
#===================================
#Setup a UDP connection
set udp3 [new Agent/UDP]
$ns attach-agent $n0 $udp3
set null4 [new Agent/Null]
$ns attach-agent $n2 $null4
$ns connect $udp3 $null4
$udp3 set packetSize_ 1500

#Setup a TCP connection
set tcp5 [new Agent/TCP]
$ns attach-agent $n1 $tcp5
set sink6 [new Agent/TCPSink]
$ns attach-agent $n2 $sink6
$ns connect $tcp5 $sink6
$tcp5 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a CBR Application over UDP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp3
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1.0Mb
$cbr0 set random_ null
$ns at 1.0 "$cbr0 start"
$ns at 2.0 "$cbr0 stop"

#Setup a CBR Application over TCP connection
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $tcp5
$cbr1 set packetSize_ 1000
$cbr1 set rate_ 1.0Mb
$cbr1 set random_ null
$ns at 1.0 "$cbr1 start"
$ns at 2.0 "$cbr1 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
