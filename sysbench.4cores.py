import sys
import subprocess
import threading

def run_sysbench():
    sysbench = subprocess.Popen(['sysbench', '--threads=4', '--cpu-max-prime=20000', 'cpu', 'run'],
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in iter(sysbench.stdout.readline, b''):
        print(line.decode(), end='')
    sysbench.stdout.close()
    return sysbench.wait()

def calculate_performance():
    total_time = 0
    total_events = 0
    while True:
        line = sysbench.stdout.readline()
        if line == b'':
            break
        if b'Total time:' in line:
            total_time = float(line.split(b' ')[-2])
        if b'Total number of events:' in line:
            total_events = int(line.split(b' ')[-1])
    print('Average performance:', total_events / total_time, 'events/sec')

# Start sysbench in a separate thread
sysbench = threading.Thread(target=run_sysbench)
sysbench.start()

# Calculate performance in the main thread
calculate_performance()

sysbench.join()

