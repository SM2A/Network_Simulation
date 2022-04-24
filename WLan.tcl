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
                 -macTrace ON \
                 -wiredRouting OFF \
                 -movementTrace OFF 


# Create nodes
set A [$ns node]
    $A set X_ 100.0
    $A set Y_ 400.0
    $A set Z_ 0.0

set B [$ns node]
    $B set X_ 50.0
    $B set Y_ 250.0
    $B set Z_ 0.0

set C [$ns node]
    $C set X_ 200.0
    $C set Y_ 300.0
    $C set Z_ 0.0

set D [$ns node]
    $D set X_ 100.0
    $D set Y_ 100.0
    $D set Z_ 0.0

set E [$ns node]
    $E set X_ 200.0
    $E set Y_ 200.0
    $E set Z_ 0.0

set F [$ns node]
    $F set X_ 200.0
    $F set Y_ 300.0
    $F set Z_ 0.0

set G [$ns node]
    $G set X_ 300.0
    $G set Y_ 300.0
    $G set Z_ 0.0
set H [$ns node]
    $H set X_ 400.0
    $H set Y_ 300.0
    $H set Z_ 0.0

set L [$ns node]
    $L set X_ 200.0
    $L set Y_ 400.0
    $L set Z_ 0.0


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
