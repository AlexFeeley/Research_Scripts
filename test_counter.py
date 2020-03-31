# Author: Alex Feeley
# Last Changed: 1-21-20
# Purpose: This file parses through PuTTY data taken in during testing and finds the total number of errors
# that occurred throughout all cycles of the test.

# Get name of testing file, and open file
file = input("Enter file name: ")

try:
    f = open(file, "rt")
except FileNotFoundError:
    print("Wrong file name.")

# Create an empty dictionary to keep data
data = {}

# Skip first line
header = f.readline()

# Parse through data in file
for line in f:
    # Split line at -, skipping lines that are just the new line character
    if line != "\n":
        temp = line.split("-")

        # Get number of shift register, and number of errors that occurred (converted to decimal)
        x = int(temp[0])
        y = int(temp[1], 16)

        # Increase count of
        if x in data:
            data[x] += y
        else:
            data[x] = y

# Create output file with same name as input file, adding _errors.txt to the end
input = file.split(".txt")
filename = input[0] + "_errors.txt"
output = open(filename, "w+")

# Print header
output.write(header)
# print(header)

# Print items in dictionary
for item in data:
    # Write items to terminal
    print(item, ": ", data[item])

    # Write items to output file
    output.write(str(item))
    output.write(": ")
    output.write(str(data[item]))
    output.write("\n")

f.close()
output.close()