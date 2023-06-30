cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun

doc: |
  Note: *Must* be run with the option --relax-path-checks. Otherwise WRF file naming
  conventions (e.g. met_em.d01.2017-12-25_00:00:00.nc) will trigger warnings about 
  illegal characters.


hints:
  DockerRequirement:
    dockerPull: ghcr.io/uomresearchit/wrf-wps:3.9.1.1
    
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
      - $(inputs.wrfinputs)
      - $(inputs.wrfbdys)
      - $(inputs.wrflowinputs)
      - $(inputs.wrffddas)

arguments: 
  - valueFrom: "wrf.exe"
    position: 2

inputs:

  rundir:
    type: Directory

  namelist:
    type: File

  wrfinputs:
    type: 
      type: array
      items: File

  wrfbdys:
    type: 
      type: array
      items: File

  wrflowinputs:
    type:
      - "null"
      - type: array
        items: File

  wrffddas:
    type:
      - "null"
      - type: array
        items: File

  cores:
    type: int
    inputBinding:
      prefix: "-np"
      position: 1
    default: 8

outputs:
  output_logs:
    type:
      type: array
      items: File
    outputBinding:
      glob: "rsl.*"
  output_wrfout:
    type:
      type: array
      items: File
    outputBinding:
      glob: "wrfout_d*"
