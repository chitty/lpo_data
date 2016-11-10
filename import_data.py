#!/usr/bin/env python
import os


OUTPUT_FILE = 'data/complete_data.txt'
DATA_DIR = 'data/'


def append_data(file):
    print 'Procesing %s' % file
    with open(OUTPUT_FILE, 'a') as output_file:
        input_file = open(file)
        input_file.readline()  # Discard header
        for line in input_file:
            output_file.write(line)
        output_file.write("\n")

for file in os.listdir(DATA_DIR):
    if file.endswith(".txt"):
        append_data(DATA_DIR+file)
