import os
import random
import matplotlib.pyplot as plt
from Analyzer import Analyzer

TCL = 'WLan.tcl'

# Default args
BANDWIDTH = '1Mb'
PACKETSIZE = '1024'
ERROR_RATE = '0.000001'

# Scenario 1: give 10 different error rates between 0.000001 and 0.00001 and detect impact on performance parameters
err_rates = []
for i in range(10):
    err_rates.append(random.uniform(0.00001, 0.000001))
    
err_rates.sort()
throughput = []
transfer_ratio = []
avg_delay = []
for err_rate in err_rates:
    prog = TCL + ' ' + BANDWIDTH + ' ' + PACKETSIZE + ' ' + str(err_rate)
    command = 'ns' + ' ' + prog
    os.system(command)
    analyzer = Analyzer('traces/' + BANDWIDTH + '-' + PACKETSIZE + '-' + str(err_rate) + '.tr')
    analyzer.parse()
    throughput.append(analyzer.throughput())
    transfer_ratio.append(analyzer.packet_transfer_ratio())
    avg_delay.append(analyzer.avg_end_to_end_delay())
    

plt.plot(err_rates, throughput, color='red', linestyle='dashed',
         linewidth=2, marker='o', markerfacecolor='red', markersize=12)
plt.xlabel('Error Rate', fontsize=16)
plt.ylabel('Throughput (byte/s)', fontsize=16)
plt.title('Throughput - Error Rate', fontsize=16)
plt.show()