# SPDX-FileCopyrightText: 2025 University of Manchester
#
# SPDX-License-Identifier: apache-2.0

cwlVersion: v1.2
class: CommandLineTool

# This CWL file defines is a tool descriptor to run the MAQSAnalyser.py script inside a Docker container.
# The script takes an input file and produces an output file named output.txt.

baseCommand: ["python3", "MAQSAnalyser.py"]

hints:
    DockerRequirement:
        dockerPull: "ghcr.io/uomresearchit/maqs-analyser:latest"
inputs:
    # Define the input file that will be provided by the user
    input_file:
        type: File
        inputBinding:
            position: 1
outputs:
    # Define the output file that will be produced by the script inside the Docker container
    output_file:
        type: File
        outputBinding:
            glob: output.txt

requirements:
    InitialWorkDirRequirement:
        listing:
            # Ensure the input file is available in the working directory
            - entryname: input_file
              entry: $(inputs.input_file)
arguments:
    # Pass the contents of the input file as an argument to the script
    - valueFrom: $(inputs.input_file.contents)
      position: 2