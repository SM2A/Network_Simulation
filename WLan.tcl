# ======================================================================
# Defining Simulation options
# ======================================================================

set opt(chan)           Channel/WirelessChannel  ;# channel type
set opt(prop)           Propagation/TwoRayGround ;# radio-propagation model
set opt(netif)          Phy/WirelessPhy          ;# network interface type
set opt(mac)            Mac/802_11               ;# MAC type
set opt(ifq)            Queue/DropTail/PriQueue  ;# interface queue type
set opt(ll)             LL                       ;# link layer type
set opt(ant)            Antenna/OmniAntenna      ;# antenna model
set opt(ifqlen)         50                       ;# max packet in ifq
set opt(adhocRouting)   AODV                     ;# routing protocol
set opt(finish)         100                      ;# time to stop simulation
set opt(x)              600                      ;# X coordinate of the topography
set opt(y)              500                      ;# Y coordinate of the topography
set opt(nNodes)         9                        ;# number of nodes

# Create the simulator object
set ns [new Simulator]

# Create direcory
set outdir "outFiles/"
file mkdir $outdir

# Set Up Tracing
$ns use-newtrace
set tracefd [open outFiles/WLan.tr w]
set namtrace [open outFiles/WLan.nam w]
$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $opt(x) $opt(y)

#Set Up Topography Object
set topo [new Topography]
$topo load_flatgrid $opt(x) $opt(y)

# Create an instance of General Operations Director, which keeps track of nodes and
# node-to-node reachability. The parameter is the total number of nodes in the simulation.
create-god $opt(nNodes)

# Configure nodes
$ns node-config -adhocRouting $opt(adhocRouting) \
                 -llType $opt(ll) \
                 -macType $opt(mac) \
                 -ifqType $opt(ifq) \
                 -ifqLen $opt(ifqlen) \
                 -antType $opt(ant) \
                 -propType $opt(prop) \
                 -phyType $opt(netif) \
                 -channel [new $opt(chan)] \
                 -topoInstance $topo \
                 -agentTrace ON \
                 -routerTrace ON \
                 -macTrace OFF \
                 -wiredRouting OFF \
                 -movementTrace OFF 


# Create nodes
set A [$ns node]
    $A set X_ 100
    $A set Y_ 400
    $A set Z_ 0

set B [$ns node]
    $B set X_ 50
    $B set Y_ 250
    $B set Z_ 0

set C [$ns node]
    $C set X_ 200
    $C set Y_ 300
    $C set Z_ 0

set D [$ns node]
    $D set X_ 100
    $D set Y_ 100
    $D set Z_ 0

set E [$ns node]
    $E set X_ 200
    $E set Y_ 200
    $E set Z_ 0

set F [$ns node]
    $F set X_ 200
    $F set Y_ 300
    $F set Z_ 0

set G [$ns node]
    $G set X_ 300
    $G set Y_ 300
    $G set Z_ 0

set H [$ns node]
    $H set X_ 400
    $H set Y_ 300
    $H set Z_ 0

set L [$ns node]
    $L set X_ 200
    $L set Y_ 400
    $L set Z_ 0

# Create UDP agents and CBR traffic sources and attach them to node A nd D
set udpA [new Agent/UDP]
set cbrA [new Application/Traffic/CBR]
$ns attach-agent $A $udpA
$cbrA attach-agent $udpA

set udpD [new Agent/UDP]
set cbrD [new Application/Traffic/CBR]
$ns attach-agent $D $udpD
$cbrD attach-agent $udpD

# Create Null agents (traffic sinks) and attach them to node H and L
set recvH [new Agent/Null]
$ns attach-agent $H $recvH

set recvL [new Agent/Null]
$ns attach-agent $L $recvL

# Connecting sender and receiver nodes
$ns connect $udpA $recvH
$ns connect $udpD $recvL

$ns initial_node_pos $A 10
$ns initial_node_pos $B 10
$ns initial_node_pos $C 10
$ns initial_node_pos $D 10
$ns initial_node_pos $E 10
$ns initial_node_pos $F 10
$ns initial_node_pos $G 10
$ns initial_node_pos $H 10
$ns initial_node_pos $L 10

$ns at 1.0 "$cbrA start"
$ns at 2.0 "$cbrD start"
$ns at $opt(finish) "finish"

proc finish {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
    exit 0
}

# Begin simulation
$ns run
