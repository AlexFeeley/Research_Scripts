# Author: Yoni Xiong
# Last Changed: 12/14/2020
# Purpose: Automously collect freq data from o-scope at set periods and write to an CSV file
# Modified from https://github.com/kiwih/agilent-rs232/blob/master/agilent-rs232.py
# Reference https://01001000.xyz/2020-05-07-Walkthrough-Agilent-Oscilloscope-RS232/

import vxi11
import time
from datetime import datetime

interval = 0.4 

instr =  vxi11.Instrument("TCPIP::169.254.178.72::INSTR")
print(instr.ask("*IDN?"))

instr.write(":WAVeform:SOURce CHANnel1\n") 

# Reset o-scope
instr.write("*RST\n") 

# Autoset 
instr.write(":AUT\n") 

# Measure freq

freq = float(instr.ask(":MEAS:FREQ? CHAN1\n"))

# Success! 
print("It worked!: Freq = %", freq)


# # No error checking here so dont enter strings
# duration = int(input("Enter the desired data collection duration in minutes (int pls.): "))
# seconds = duration * 60
# times = int(seconds / interval) # measure every 2 seconds

# # Open the output file as csv
# filename = input("Output Filename (w/o file extension): ")
# with open(filename + ".csv", 'w') as f:

#     # Let's now try get the data! (may be a bit offest from desired times depending on execution times for serial ops)
#     for i in range(times):

#         # Autoset the o-scope
#         instr.write(b':AUT\n')

#         # Read the frequency
#         instr.write(b':MEAS:FREQ? CHAN1\n') 
#         freq = float(instr.readline())

#         # Get current time
#         currTime = str(datetime.now().strftime("%d/%m/%Y %H:%M:%S"))

#         # Write the frequency to an output file .cvs
#         writeString = str(currTime + ","+ str(freq)+ "\n")
#         f.write(writeString)

#         # Print result to console
#         result = str(currTime + " " + str(freq))
#         print(result)

#         # Sleep for interval seconds
#         time.sleep(interval) 

# # Close the port
# instr.close() 

# # Add functionality to plot the results later
# input("Done! Press Enter to Exit")






