cwlVersion: v1.2
class: CommandLineTool
baseCommand: "metgrid.exe"

doc: |
  Creates meteorological input files for WRF, using
  ungribbed model data, generated using ungrib; and
  the geographic input file (geo_em*) generated by geogrid.

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"

hints:
  DockerRequirement:
    dockerPull: ghcr.io/uomresearchit/wrf-wps:latest
    
requirements:
  LoadListingRequirement:
    loadListing: deep_listing
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.geofile)
        entryname: geo_em.d01.nc
      - entry: $(inputs.namelist)
        entryname: namelist.wps
      - entry: $(inputs.ungribbed_files_a)
      - entry: $(inputs.ungribbed_files_b)
      - entry: $(inputs.metdir)




inputs:

  geofile:
    type: File

  namelist:
    type: File

  ungribbed_files_a:
    type: File[]

  ungribbed_files_b:
    type: File[]?

  nproc:
    type: int
    default: 2

  metdir:
    type: Directory

outputs:
  logfile:
    type:
      type: array
      items: File
    outputBinding:
      glob: "metgrid*log"
  metfiles:
    type:
      type: array
      items: File
    outputBinding:
      glob: "met_em.*.nc"
    
