import os
import random
import matplotlib.pyplot as plt
from Analyzer import Analyzer


TCL = 'WLan.tcl'

# Default args
PACKETSIZE = '2048'
ERROR_RATE = '0.00001'

# Scenario 2: 
    
bandwidthes = [1.5, 55, 155]
throughput = []
transfer_ratio = []
avg_delay = []
for bw in bandwidthes:
    prog = TCL + ' ' + str(bw) + 'Mb' + ' ' + PACKETSIZE + ' ' + ERROR_RATE
    command = 'ns' + ' ' + prog
    os.system(command)
    analyzer = Analyzer('traces/' +str(bw) + 'Mb' + '-' + PACKETSIZE + '-' + ERROR_RATE + '.tr')
    analyzer.parse()
    throughput.append(analyzer.throughput())
    transfer_ratio.append(analyzer.packet_transfer_ratio())
    avg_delay.append(analyzer.avg_end_to_end_delay())