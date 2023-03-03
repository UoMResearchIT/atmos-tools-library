cwlVersion: v1.2
class: CommandLineTool

baseCommand: [/bin/bash, '-c']

doc: |
  This command-line script will extract, and tidy up, the geogrid directory
  for WPS from the WRF docker container. It takes 2 inputs, a simple boolean
  which fulfils CWL's input requirements, and an optional string for replacing
  the copy command, if required.
  
  The purpose of this script is to enable the use of the run-time input files which
  are bundled with the WRF source code. If you need to modify any of these then we
  recommend extracting the directory using:
      cwltool create_metgrid_dir.cwl --generate_metdir
  then modifying the files as needed, and providing the directory as an input 
  to your main workflow. 
hints:
  DockerRequirement:
    dockerPull: ghcr.io/uomresearchit/wrf-wps:latest


inputs:
  generate_metdir:
    type: boolean
  
  script:
    type: string?
    default: |
      mkdir ./metgrid
      cp /WPS-run/metgrid/METGRID* metgrid/
      cp /WPS-run/metgrid/gribmap.txt metgrid/
    inputBinding:
      position: 1

outputs:
  metdir:
    type: Directory
    outputBinding:
      glob: "metgrid"
