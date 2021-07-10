from queue import Queue

# Number of ring oscillators
RO_NUM = 14
fRO = "C20_1048mV_Copy.csv"

def update_averages(frequency, frequencyIndex):
    print(frequencyIndex)
    print(averages)
    print(counts)
    if frequencyIndex > len(averages):
        averages.append(frequency)
        counts.append(1)
    else:        
        averages[frequencyIndex] = (averages[frequencyIndex] * counts[frequencyIndex] + frequency) / (counts[frequencyIndex] + 1)
        counts[frequencyIndex] += 1
    print("done")

f = open(fRO, "rt")
filename = fRO + "_post.csv"
output = open(filename, "w+")


queueList = []
for i in range(RO_NUM):
    queueList.append(Queue(maxsize=0))

# Init error line, counter, and errorSR values 
freqCounter = 0
counter = 0
minDiff = 100

# treat first line different
first = f.readline()
first = f.readline()
first = f.readline()
first = f.readline()
first = f.readline()
first = f.readline()
first = f.readline()
first = f.readline()
first = f.readline()


# read the real data
temp = first.split(",")
prevFreq = float(temp[1])

# freq set
freqSet = [prevFreq]
setCounter = 1

# Parse through all data in file
for line in f:
    
    if counter < 50: 
        # Split line at ,
        temp = line.split(",")

        time = temp[0]
        freq = float(temp[1])

        diff = abs(freq - prevFreq)
        print(freq)

        # just skip the first two ROs
        if freq > 80000000: 
            continue

        if diff > 200000 : 
            # different frequency
            # take average of freqSet, clear it, and reset counter to zero 
            average = sum(freqSet)/setCounter

            # start new list and increment counter 
            freqSet = [freq,0,0,0,0,0,0]
            setCounter = 1
            queueList[freqCounter].put(average)
            freqCounter += 1
            if freqCounter > RO_NUM - 1 :
                freqCounter = 0
            if freqCounter == 8: 
                if freq > 11E+6: 
                    # skip
                    freqCounter += 1
        else: 
            # part of same freq set, add to array
            freqSet[setCounter] = freq
            setCounter += 1
            
        prevFreq = freq
        counter +=1

tempString = ''
for freqQueue in queueList:
    # print(list(freqQueue.queue))
    # csvString = ''.join(list(freqQueue.queue))
    csvString = ','.join([str(i) for i in list(freqQueue.queue)])
    output.write(csvString)
    output.write("\n")

# print("%2d, %2d" % (temp1,temp2))
# print("\n")

f.close()
output.close()

# https://thispointer.com/python-add-a-column-to-an-existing-csv-file/ 
