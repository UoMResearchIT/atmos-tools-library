cwlVersion: v1.2
class: ExpressionTool

doc: |
  This javascript tool provides a method for renaming WRF output files 
  so that they are readable by EMEP. It will take a list of WRF files and: 
   a) extract the date information (e.g. YYYY-MM-DD_HH)
   b) create a new filename, using provided string prefix
   c) return them within a directory, rather than as a list of files
  
requirements:
  InlineJavascriptRequirement: {}

inputs:
  wrf_files: File[]
  
  file_prefix:
    type: string
    default: "wrfdata_"
  
  dir_name:
    type: string
    default: "wrf_data"
    
  
outputs:
  wrf_dir: Directory

expression: |
  ${ function generate_suffix(a){
       var dateinfo = a.basename.match(/\d{4}-\d{2}-\d{2}_\d{2}/);
       return dateinfo
     }
  var out_array = inputs.wrf_files
  for (var i = 0; i < out_array.length; i++ ){
     out_array[i].basename = inputs.file_prefix+generate_suffix(out_array[i])
  }
  return {"grib_dir":
      {"class": "Directory", "basename": inputs.dir_name, "listing": out_array}
  }
  }