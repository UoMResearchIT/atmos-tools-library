cwlVersion: v1.2
class: ExpressionTool

doc: |
  This javascript tool replaces the `link_grib.sh` shell script that
  ships with WPS. It will take a list of GRIB files and: 
   a) sort them by name
   b) rename them following the naming convention `GRIBFILE.AAA`, 
      `GRIBFILE.AAB`, etc.
   c) return them within a directory, rather than as a list of files
  
requirements:
  InlineJavascriptRequirement: {}

inputs:
  grib_files: File[]
  
outputs:
  grib_dir: Directory

expression: |
  ${ function sortnames(a, b){
       var comparison = a.basename > b.basename;
       return comparison == true ? 1 : -1
     }
     function generate_suffix(a){
       var alpha = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", 
                     "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
       var aletter = alpha[a%26]
       var bletter = alpha[Math.floor((a/26)%26)]
       var cletter = alpha[Math.floor((a/(26*26))%26)]
       return cletter + bletter + aletter
     }
  var out_array = inputs.grib_files.sort(sortnames)
  for (var i = 0; i < out_array.length; i++ ){
     out_array[i].basename = "GRIBFILE."+generate_suffix(i)
  }
  return {"grib_dir":
      {"class": "Directory", "basename": "ungrib_directory", "listing": out_array}
  }
  }