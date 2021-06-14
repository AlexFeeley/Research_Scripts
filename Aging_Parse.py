from queue import Queue

# Number of ring oscillators
RO_NUM = 16

fRO = "C20_1048mV_Copy.csv"
f = open(fRO, "rt")
filename = fRO + "_post.txt"
output = open(filename, "w+")

# Create an empty q's to keep data
q1 = Queue(maxsize=0)
q2 = Queue(maxsize=0)
q3 = Queue(maxsize=0)
q4 = Queue(maxsize=0)
q5 = Queue(maxsize=0)
q6 = Queue(maxsize=0)
q7 = Queue(maxsize=0)
q8 = Queue(maxsize=0)
q9 = Queue(maxsize=0)
q10 = Queue(maxsize=0)
q11 = Queue(maxsize=0)
q12 = Queue(maxsize=0)
q13 = Queue(maxsize=0)
q14 = Queue(maxsize=0)
q15 = Queue(maxsize=0)
q16 = Queue(maxsize=0)

# Init error line, counter, and errorSR values 
freqCounter = 1
counter = 0
i = 0
minDiff = 100

# treat first line different
first = f.readline()
temp = first.split(",")
tempFreq = float(temp[1])

# Parse through all data in file
for line in f:
    
    if counter < 100:
        # Split line at ,
        temp = line.split(",")

        time = temp[0]
        freq = float(temp[1])

        diff = abs(freq - tempFreq)

        if diff > 1000000: 
            # different frequency!
            if freqCounter == 1: 
                q1.put(tempFreq)
            if freqCounter == 2: 
                q2.put(tempFreq)
            if freqCounter == 3: 
                q3.put(tempFreq)
            if freqCounter == 4: 
                q4.put(tempFreq)
            if freqCounter == 5: 
                q5.put(tempFreq)
            if freqCounter == 6: 
                q6.put(tempFreq)
            if freqCounter == 7: 
                q7.put(tempFreq)
            if freqCounter == 8: 
                q8.put(tempFreq)
            if freqCounter == 9: 
                q9.put(tempFreq)
            if freqCounter == 10: 
                q10.put(tempFreq)
            if freqCounter == 11: 
                q11.put(tempFreq)
            if freqCounter == 12: 
                q12.put(tempFreq)
            if freqCounter == 13: 
                q13.put(tempFreq)
            if freqCounter == 14: 
                q14.put(tempFreq)
            if freqCounter == 15: 
                q15.put(tempFreq)
            if freqCounter == 16: 
                q16.put(tempFreq)
            freqCounter += 1
            if freqCounter > RO_NUM :
                freqCounter = 1
            print(freqCounter)
        tempFreq = freq
        counter += 1
temp1 = q1.get()
print(temp1)
temp1 = q1.get()
print(temp1)


temp16 = q16.get()
print(temp16)
temp16 = q16.get()
print(temp16)

# print("%2d, %2d" % (temp1,temp2))
# print("\n")

f.close()
output.close()

# https://thispointer.com/python-add-a-column-to-an-existing-csv-file/ 
