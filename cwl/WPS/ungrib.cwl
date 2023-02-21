cwlVersion: v1.2
class: CommandLineTool
baseCommand: "/WRF-SOURCES/WPS/WPS-src/ungrib.exe"

doc: |
  Extracts data from supplied GRIB files according to the 
  provided variable table. The root of the output file names
  should be provided for pattern matching.

hints:
  DockerRequirement:
    dockerPull: ghcr.io/uomresearchit/wrf-wps:latest
    
requirements:
  LoadListingRequirement:
    loadListing: shallow_listing
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.vtable)
        entryname: Vtable
      - entry: $(inputs.namelist)
        entryname: namelist.wps
      - entry: $(inputs.grib_dir.listing)

inputs:

  vtable:
    type: File

  namelist:
    type: File

  grib_dir:
    type: Directory

  outname:
    type: string

outputs:
  logfile:
    type: File
    outputBinding:
      glob: "ungrib.log"
  procfiles:
    type:
      type: array
      items: File
    outputBinding:
      glob: "$(inputs.outname)*"
