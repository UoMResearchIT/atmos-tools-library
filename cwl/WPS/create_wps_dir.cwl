cwlVersion: v1.2
class: CommandLineTool

baseCommand: [/bin/bash, '-c']

doc: |
  This command-line script will extract, and tidy up, the run directory
  for WPS from the WRF docker container. It takes 2 inputs, a simple boolean
  which fulfils CWL's input requirements, and an optional string for replacing
  the copy command, if required.
  
  The purpose of this script is to enable the use of the run-time input files which
  are bundled with the WRF source code. If you need to modify any of these then we
  recommend extracting the directory using:
      cwltool create_wps_dir.cwl --generate_wpsdir
  then modifying the files as needed, and providing the directory as an input 
  to your main workflow. 
hints:
  DockerRequirement:
    dockerPull: ghcr.io/uomresearchit/wrf-wps:3.9.1.1


inputs:
  generate_wpsdir:
    type: boolean
  
  script:
    type: string?
    default: |
      mkdir ./WPS-dir
      mkdir ./WPS-dir/geogrid
      mkdir ./WPS-dir/metgrid
      mkdir ./WPS-dir/ungrib
      cp /WPS-run/geogrid/GEOGRID* WPS-dir/geogrid/
      cp /WPS-run/metgrid/METGRID* WPS-dir/metgrid/
      cp /WPS-run/metgrid/gribmap.txt WPS-dir/metgrid/
      cp /WPS-run/geogrid/gribmap.txt WPS-dir/geogrid/
      cp -r /WPS-run/ungrib/Variable_Tables WPS-dir/ungrib/
    inputBinding:
      position: 1

outputs:
  wpsdir:
    type: Directory
    outputBinding:
      glob: "WPS-dir"
