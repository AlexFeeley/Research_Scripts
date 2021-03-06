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

    # Gets start, end, and interval time
    start_time = input("Enter start time in 00:00:00 format: ")
    end_time = input("Enter end time in 00:00:00 format: ")
    interval = int(input("Enter how frequently you want to sample the data in seconds: "))

    # Change this to filter out currents below this limit
    lower_limit = 0.001

    print("Writing to CSV file... ")

    # Creates a .csv file with identical name as original file but with _Adjusted.csv
    with open(filename.replace(".txt", "") + "_Removed.csv", 'w') as v:
        write_heading(v)

        # Defines previous time calculated from input file for comparison
        old_time = 0

        # Boolean to ensure data written to .csv is between start and end times
        time_passed = False

        # Counter to only write lines of a certain interval
        counter = 0

        # Parse through every line in original file
        for dataLine in dataList:
            m = dataLine.split()
            time = m[5]
            current = float(m[3])

            # Check if two times are the same, skip the second time if this is true
            if old_time == time:
                continue

            # Check that times are within bounds specified
            if time == start_time:
                time_passed = True
            if time == end_time:
                time_passed = False

            # Save old time, before time is reset
            old_time = time

            # If between bounds of data wanted, write data to .csv file
            if time_passed:

                # Counter to only sample data every x seconds
                counter = counter + 1

                if counter < interval:
                    continue
                else:
                    counter = 0

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