import os
import random

TCL = 'WLan.tcl'

# Default args
BANDWIDTH = '1Mb'
PACKETSIZE = '512'
ERROR_RATE = '0.000001'

# Scenario 1 -- 10 different error rates between 0.000001 and 0.00001
err_rates = []
for i in range(10):
    err_rates.append(random.uniform(0.00001, 0.000001))
    
err_rates.sort()

for err_rate in err_rates:
    os.system('ns' + ' ' + TCL + ' ' + BANDWIDTH + ' ' + PACKETSIZE + ' ' + str(err_rate))

