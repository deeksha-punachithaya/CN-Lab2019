set ns [new Simulator]

$ns rtproto Static

set tracefile [open one.tr w]
$ns trace-all $tracefile
set namfile [open one.nam w]
$ns namtrace-all $namfile

proc finish {} {
	global ns namfile tracefile
	$ns flush-trace
	close $tracefile
	close $namfile
	exec awk -f one.awk one.tr &
	exec nam one.nam &
	exit 0
}

set n(1) [$ns node]
set n(2) [$ns node]
set n(3) [$ns node]

$ns duplex-link $n(1) $n(2) 0.5Mb 20ms DropTail
$ns duplex-link $n(2) $n(3) 0.5Mb 20ms DropTail
$ns queue-limit $n(1) $n(2) 10
$ns queue-limit $n(2) $n(3) 10

#create a UDP agent 
set udp0 [new Agent/UDP]
$ns attach-agent $n(1) $udp0

#create a CBR traffic source
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 512
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0

$ns connect $udp0 $null0
$udp0 set fid_ 2

$ns at 0.5 "$cbr0 start"
$ns at 2.0 "$cbr0 stop"
$ns at 2.0 "finish"

$ns run
