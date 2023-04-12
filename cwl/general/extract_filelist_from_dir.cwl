cwlVersion: v1.2
class: CommandLineTool

doc: |
  This simple tool extracts a filelist from a directory listing
  
requirements:
  InlineJavascriptRequirement: {}
  LoadListingRequirement:
    loadListing: shallow_listing
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.directory.listing)

inputs:
  directory: Directory
  
outputs:
  filelist:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*"

baseCommand: ls
