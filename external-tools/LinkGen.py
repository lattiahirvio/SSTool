#!/bin/python
import requests
import os

# Get the directory of the script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Construct relative paths from the script directory
results_file_path = os.path.join(script_dir, "../output/results.txt")
dumpJ_file_path = os.path.join(script_dir, "../output/dumpJ.txt")

# Define the URL for file.io
url = 'https://file.io/'

# Post the 'results.txt' file
with open(results_file_path, 'rb') as results_file:
    data = {'file': results_file}
    response = requests.post(url, files=data)
    res = response.json()
    print(res["link"])

# Post the 'dumpJ.txt' file
with open(dumpJ_file_path, 'rb') as dumpJ_file:
    data = {'file': dumpJ_file}
    response = requests.post(url, files=data)
    res = response.json()
    print(res["link"])

