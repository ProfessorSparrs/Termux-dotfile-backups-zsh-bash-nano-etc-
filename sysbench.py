import sys
import subprocess
import threading

def run_stress_ng():
    stress_ng = subprocess.Popen(['stress-ng', '--cpu', '8', '--cpu-method', 'matrixprod', '--metrics-brief'],
                                 stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in iter(stress_ng.stdout.readline, b''):
        print(line.decode(), end='')
    stress_ng.stdout.close()
    return stress_ng.wait()

def calculate_performance():
    while True:
        total_time = 0
        total_events = 0
        line = stress_ng.stdout.readline()
        if line == b'':
            break
        if b'Total time:' in line:
            total_time = float(line.split(b' ')[-2])
        if b'Total number of events:' in line:
            total_events = int(line.split(b' ')[-1])
        if total_time > 0 and total_events > 0:
            print('Average performance:', total_events / total_time, 'events/sec')

# Start stress-ng in a separate thread
stress_ng = threading.Thread(target=run_stress_ng)
stress_ng.start()

# Calculate performance in the main thread
calculate_performance()

stress_ng.join()
