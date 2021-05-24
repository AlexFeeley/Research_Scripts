# Author: Yoni Xiong
# Last Changed: 12/14/2020
# Purpose: Automously collect freq data from o-scope at set periods and write to an CSV file
# Modified from https://github.com/kiwih/agilent-rs232/blob/master/agilent-rs232.py
# Reference https://01001000.xyz/2020-05-07-Walkthrough-Agilent-Oscilloscope-RS232/

# pip install XXX
import serial
import argparse
import time
from datetime import datetime

# Initiate the parser
parser = argparse.ArgumentParser()

# defaults
# port = "/dev/tty.usbserial-FT1JI466"
port = 'COM3'
baud = 9600 #57600
channel = 1
length = 1000
interval = 2

# Add arguments
parser.add_argument("--port", "-p", help="set serial port (default %s)" % port)
parser.add_argument("--baud", "-b", help="set serial baud rate (default %d)" % baud)
parser.add_argument("--channel", "-c", help="set probe channel (default %d)" % channel)
parser.add_argument("--length", "-l", help="number of samples (default %d)" % length)

# Read arguments from the command line
args = parser.parse_args()

# Evaluate given options
if args.port:
    port = args.port
if args.baud:
    baud = int(args.baud)
if args.channel:
    channel = int(args.channel)
if args.length:
    if args.length in ("100", "250", "500", "1000", "2000", "MAXimum"):
        length = args.length
    else:
        print("Invalid length (must be in {100, 250, 500, 1000, 2000, MAXimum}")
        exit(1)
    
# Open serial port using the DTR hardware handshaking mode and 57600 baud
# A timeout is useful when deciding if a response is "finished"
ser = serial.Serial(port, baud, dsrdtr=True, timeout=1)  

# Ensure the scope is awake and talking
ser.write(b'*IDN?\n')
ser.flush() #flush the serial to ensure the write is sent

# Let's get the response
scope_idn = ser.readline() 

# Check the ID
if scope_idn[0:7] != b'AGILENT':
    print("Unexpected response from Agilent scope, check your connection and try again")
    ser.close()
    exit()

# Set it to examine channel 1 or channel 2
if channel == 1:
    ser.write(b':WAVeform:SOURce CHANnel1\n') 
else:
    ser.write(b':WAVeform:SOURce CHANnel2\n') 

# Reset o-scope
ser.write(b'*RST\n') 
ser.flush()

# Autoset 
ser.write(b':AUT\n') 
ser.flush()

# Measure freq
ser.write(b':MEAS:FREQ? CHAN1\n') 
ser.flush()
freq = float(ser.readline())

# Success! 
print("It worked!: Freq = %", freq)

# Flush it for fun
ser.flush()

# No error checking here so dont enter strings
duration = int(input("Enter the desired data collection duration in minutes (int pls.): "))
seconds = duration * 60
times = int(seconds / interval) # measure every 2 seconds

# Open the output file as csv
filename = input("Output Filename (w/o file extension): ")
with open(filename + ".csv", 'w') as f:

    # Let's now try get the data! (may be a bit offest from desired times depending on execution times for serial ops)
    for i in range(times):

        # Autoset the o-scope
        ser.write(b':AUT\n')
        ser.flush()

        # Read the frequency
        ser.write(b':MEAS:FREQ? CHAN1\n') 
        ser.flush()
        freq = float(ser.readline())

        # Get current time
        currTime = str(datetime.now().strftime("%d/%m/%Y %H:%M:%S"))

        # Write the frequency to an output file .cvs
        writeString = str(currTime + ","+ str(freq)+ "\n")
        f.write(writeString)

        # Print result to console
        result = str(currTime + " " + str(freq))
        print(result)

        # Sleep for interval seconds
        time.sleep(interval) 

# Close the port
ser.close() 

# Add functionality to plot the results later
input("Done! Press Enter to Exit")



