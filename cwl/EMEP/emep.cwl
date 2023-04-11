cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun

doc: |
  EMEP chemistry transport model. Note that the configuration for the
  model will be controlled via a namelist file - make sure the settings
  provided here match those in the namelist file.
  
  This takes the following inputs:
   - namelist: 
     - namelist file
     - will be renamed config_emep.nml
   - inputdir: 
     - directory containing general input files
     - should be the path defined in DataPath(1) of namelist
   - metdir: 
     - directory containing meteorology input files
     - should be the path defined in meteo of namelist
     - file names should match the string defined within meteo, e.g.
       wrfout_d01_YYYY-MM-DD_hh
   - chembdys:
     - optional
     - array of chemistry dump files from another EMEP simulation
     - names for these should match the strings defined in
       NEST_template_read_3D and NEST_template_readBC in the namelist
   - cores:
     - number of cores to use for MPI parallisation
     - default is 8
   - runlabel
     - string used for capturing output files
     - should match the string defined in runlabel1 of namelist
   - chemoutlabel
     - string used for capturing EMEP dump files, for nesting
     - should match the string defined in NEST_template_write of namelist

  The following outputs are available:
   - output_logs:
     - general log files for running model
   - output_files:
     - general output files, file names defined by 'runlabel' input string
   - output_chembdys:
     - chemical boundary output files, file names defined by 'chemoutlabel' input string

hints:
  DockerRequirement:
    dockerPull: ghcr.io/uomresearchit/emep:latest
    
requirements:
  NetworkAccess:
    networkAccess: True
  LoadListingRequirement:
    loadListing: shallow_listing
  InitialWorkDirRequirement:
    listing:
      - $(inputs.inputdir)
      - entry: $(inputs.namelist)
        entryname: config_emep.nml
      - $(inputs.metdir)
      - $(inputs.chembdys)

arguments: 
  - valueFrom: "emepctm"
    position: 2

inputs:

  inputdir:
    type: Directory

  namelist:
    type: File

  metdir:
    type: Directory

  chembdys:
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

  runlabel:
    type: string

  chemoutlabel:
    type: string
    default: "EMEP_OUT"

outputs:
  output_logs:
    type:
      type: array
      items: File
    outputBinding:
      glob: ["*.txt","*.out"]
  output_files:
    type:
      type: array
      items: File
    outputBinding:
      glob: "$(inputs.runlabel)*.nc"
  output_chembdys:
    type:
      type: array
      items: File
    outputBinding:
      glob: "$(inputs.chemoutlabel)*.nc"
