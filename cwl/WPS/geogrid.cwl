cwlVersion: v1.2
class: CommandLineTool
baseCommand: "geogrid.exe"

doc: |
  Creates the geographic input files (geo_em*) for 
  use by the other WPS tools.
  
  The geography directory should be passed as the 
  argument `geodir`. In your namelist you will need 
  to set:
    * `geog_data_path = './geodir/'`
    * `opt_geogrid_tbl_path = './'`

hints:
  DockerRequirement:
    dockerPull: ghcr.io/uomresearchit/wrf-wps:latest
    
requirements:
  LoadListingRequirement:
    loadListing: deep_listing
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.geodir)
        entryname: geodir
      - entry: $(inputs.namelist)
        entryname: namelist.wps
      - entry: $(inputs.geotable)
        entryname: GEOGRID.TBL




inputs:

  geodir:
    type: Directory

  namelist:
    type: File

  geotable:
    type: File

outputs:
  logfile:
    type:
      type: array
      items: File
    outputBinding:
      glob: "geogrid*log"
  metfiles:
    type:
      type: array
      items: File
    outputBinding:
      glob: "geo_em.*.nc"
    
