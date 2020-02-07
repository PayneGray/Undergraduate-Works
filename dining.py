# Payne Lacsamana

import time
import threading

status = ["thinking","thinking","thinking","thinking","thinking"]
eaten = [0,0,0,0,0]
chopstick = []
for i in range(5):
	chopstick.append(threading.Condition(threading.Lock()))
def print_status(arr):
	output = "\t"
	for i in arr:
		output = output+i+"   |"
	print output
def philosopher(num):
	global status
	while eaten[num]<3:
		status[num]="*Hungry*"
		chopstick[num].acquire()
		chopstick[(num+1)%5].acquire()
		eaten[num]+=1
		status[num]="EATING ("+str(eaten[num])+")"
		time.sleep(2)
		chopstick[num].release()
		chopstick[(num+1)%5].release()
		status[num]="thinking"
		time.sleep(2)
	status[num]="thinking"
def status_update():
	while eaten[0]<3 or eaten[1]<3 or eaten[2]<3 or eaten[3]<3 or eaten[4]<3:
		print_status(status)
		time.sleep(2)
def main():

	philosophers = []
	status_updater = threading.Thread(target=status_update)
	status_updater.start()
	for i in range(5):
		philosophers.append(threading.Thread(target=philosopher,args=(i,)))
	for p in philosophers:
		p.start()

main()
