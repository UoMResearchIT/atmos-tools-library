cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun

doc: |
  Note: *Must* be run with the option --relax-path-checks. Otherwise WRF file naming
  conventions (e.g. met_em.d01.2017-12-25_00:00:00.nc) will trigger warnings about 
  illegal characters.

hints:
  DockerRequirement:
    dockerPull: ghcr.io/uomresearchit/wrf-wps:latest
    
requirements:
  NetworkAccess:
    networkAccess: True
  LoadListingRequirement:
    loadListing: shallow_listing
  InitialWorkDirRequirement:
    listing:
      - $(inputs.rundir.listing)
      - entry: $(inputs.namelist)
        entryname: namelist.input
      - $(inputs.metfiles)

arguments: 
  - valueFrom: "real.exe"
    position: 2

inputs:

  rundir:
    type: Directory

  namelist:
    type: File

  metfiles:
    type: File[]

  cores:
    type: int
    inputBinding:
      prefix: "-np"
      position: 1
    default: 4

outputs:
  output_logs:
    type:
      type: array
      items: File
    outputBinding:
      glob: "rsl.*"
  output_wrfinput:
    type:
      type: array
      items: File
    outputBinding:
      glob: "wrfinput_d*"
  output_wrfbdy:
    type: 
      type: array
      items: File
    outputBinding:
      glob: "wrfbdy_d*"
  output_wrflowinput:
    type: 
      type: array
      items: File
    outputBinding:
      glob: "wrflowinp_d*"
  output_wrffdda:
    type:
      type: array
      items: File
    outputBinding:
      glob: "wrffdda_d*"
