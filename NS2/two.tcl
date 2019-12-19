set ns [new Simulator]

set tracefile [open two.tr w]
$ns trace-all $tracefile
set namfile [open two.nam w]
$ns namtrace-all $namfile

proc finish{} {
	global ns namfile tracefile
	$ns flush-trace
	
	close $tracefile
	close $namfile
	exec awk -f two.awk two.tr &
	exec nam two.nam &
	exit 0
}

set n(0) [$ns node]
set n(1) [$ns node]
set n(2) [$ns node]
set n(3) [$ns node]

$ns duplex-link $n(0) $n(2) 2Mb 10ms DropTail
$ns duplex-link $n(1) $n(2) 2Mb 10ms DropTail
$ns duplex-link $n(2) $n(3) 900kb 10ms DropTail

$ns queue-limit $n(0) $n(2) 10

set tcp0 [new Agent/TCP]
$ns attach-agent $n(0) $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink0
$ns connect $tcp0 $sink0

set telnet [new Application/Telnet]
$telnet attach-agent $tcp0
$telnet set interval 0

set tcp1 [new Agent/TCP]
$ns attach-agent $n(1) $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink1
$ns connect $tcp1 $sink1

set ftp [new Application/FTP]
$ftp attach-agent $tcp1
$ftp set type_ FTP

$ns at 0.5 "$telnet start"
$ns at 0.6 "$ftp start"
$ns at 24.5 "$telnet stop"
$ns at 24.5 "$ftp stop"
$ns at 25.0 "finish"

$ns run
























