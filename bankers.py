#Payne Lacsamana

import threading
import random
import time

NUM_OF_CUSTOMERS = 5
NUM_OF_RESOURCES = 3

counter = 0
allocation = [[0,1,0],[2,0,0],[3,0,2],[2,1,1],[0,0,2]]
maximum = [[7,5,3],[3,2,2],[9,0,2],[2,2,2],[4,3,3]]
available = [5,3,3]

work = []
need = []
sequence = []
finish = [False,False,False,False,False]

for i in available:
	work.append(i)

def init_need():
	temp = []
	global need
	for i in range(NUM_OF_CUSTOMERS):
		temp.append(maximum[i])

	for i in range(NUM_OF_CUSTOMERS):
		for j in range(NUM_OF_RESOURCES):
			temp[i][j] = temp[i][j]-allocation[i][j]
	need = temp


def isSafe(num):
	for i in range(NUM_OF_RESOURCES):
		if need[num][i]>work[i]:
			return False
	return True

def release_resources(customer_num):

	for i in range(NUM_OF_RESOURCES):
		work[i]+=allocation[customer_num][i]
	print "process",customer_num,"released resources"
	
	sequence.append(customer_num)

def request_resources(customer_num):
	global counter
	while finish[customer_num]==False and counter <100:

		if isSafe(customer_num):
			print "process",customer_num,"is finished"
			release_resources(customer_num)
			finish[customer_num]=True

		else:
			print "process",customer_num,"cannot finish"
		time.sleep(1)

		counter +=1


def main():
	init_need()
	customers = []
	for i in range(NUM_OF_CUSTOMERS):
		customers.append(threading.Thread(target=request_resources,args=(i,)))
	for i in range(NUM_OF_CUSTOMERS):
		customers[i].start()
	for i in range(NUM_OF_CUSTOMERS):
		customers[i].join()
	if len(sequence)<5:
		print "system is unsafe"
	else:
		print "sequence:",sequence
main()