#!/usr/bin/env python3

import subprocess
import sys
import json
import os

def load_strings_from_json(json_path):
    with open(json_path, "r") as json_file:
        return json.load(json_file)

# Check if PID and JSON path are provided
if len(sys.argv) != 3:
    print("Usage: {} <PID> <JSON_PATH>".format(sys.argv[0]))
    sys.exit(1)

PID = sys.argv[1]
JSON_PATH = sys.argv[2]

dumpJ_path = "output/dumpJ.txt"

# Check if dumpJ.txt exists
if not os.path.exists(dumpJ_path):
    # Internal Checks Java
    with open(dumpJ_path, "w") as dump_file:
        subprocess.run(["sudo", "external-tools/lsdumper", PID], stdout=dump_file, text=True, check=True)

    print("Created dumpJ")

strings_to_check = load_strings_from_json(JSON_PATH)

with open(dumpJ_path, "r") as dump_file:
    dump_content = dump_file.read()

with open("output/results.txt", "a") as results_file:
    for module, strings in strings_to_check.items():
        for string in strings:
            if string in dump_content:
                # Extract module name from JSON key and print result
                results_file.write("[⚠️] Failed {} [In instance]\n".format(module))
                print("[⚠️] Failed {} [In instance]\n".format(module))
