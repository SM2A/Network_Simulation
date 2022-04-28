import os
import random
import matplotlib.pyplot as plt
from Analyzer import Analyzer


TCL = 'WLan.tcl'

# Default args
BANDWIDTH = '1Mb'
ERROR_RATE = '0.00001'

# Scenario 2: 
    
packet_sizes = [128, 256, 512, 1024, 1500, 1800,  2048, 4096]
throughput = []
transfer_ratio = []
avg_delay = []
for psize in packet_sizes:
    prog = TCL + ' ' + BANDWIDTH + ' ' + str(psize) + ' ' + ERROR_RATE
    command = 'ns' + ' ' + prog
    os.system(command)
    analyzer = Analyzer('traces/' + BANDWIDTH + '-' + str(psize) + '-' + ERROR_RATE + '.tr')
    analyzer.parse()
    throughput.append(analyzer.throughput())
    transfer_ratio.append(analyzer.packet_transfer_ratio())
    avg_delay.append(analyzer.avg_end_to_end_delay())