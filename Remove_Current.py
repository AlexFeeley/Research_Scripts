# Author: Alex Feeley
# Last Changed: 3-31-2020
# Purpose: This file parses through a file and removes all currents below 1 mA

from os import path


def main():
    dataList = []

    # Verifies file exists, reprompts for valid filename if not, and opens file
    filename = input("Filename: ")
    while not path.exists(filename):
        filename = input("Please enter a valid filename: ")

    with open(filename, 'r') as f:
        for line in f:
            dataList.append(line)

    # Change this to filter out currents below this limit
    lower_limit = 0.001

    print("Writing to CSV file... ")

    # Creates a .csv file with identical name as original file but with _Adjusted.csv
    with open(filename.replace(".txt", "") + "_Removed.csv", 'w') as v:
        write_heading(v)

        # Parse through every line in original file
        for dataLine in dataList:
            m = dataLine.split()
            current = float(m[3])

            if current >= lower_limit:
                # Counter to write new line after every line of data
                i = 0

                # Write data if current is greater than 0.001
                for data in m:
                    i = i + 1
                    v.write(data)
                    v.write(',  ')

                    if i == 7:
                        v.write("\n")


# Helper method to write heading to .csv file
def write_heading(v):
    v.write("VDD (V)")
    v.write(", ")
    v.write("Current (A)")
    v.write(", ")
    v.write("VDDPST (V)")
    v.write(", ")
    v.write("Current (A)")
    v.write(", ")
    v.write("Date")
    v.write(", ")
    v.write("Time")
    v.write(", \n")


# Call main function
main()