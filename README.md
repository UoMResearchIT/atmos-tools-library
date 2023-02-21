# Atmospheric Tool Library

This is a library of tool descriptors for atmospheric science relevant tools.

The principle language supported is [Common Workflow Language (CWL)](https://www.commonwl.org/).

## Tools

### WRF

- *create run dir*: creates a run directory, from the WRF docker container, for use with WRF and REAL programs
- *real*: runs the REAL program, to create WRF input files
- *wrf*: runs the WRF model

### WPS

- *create metgrid dir*: creates a run directory for the metgrid program
- *create wps dir*: creates a run directory for general wps use
- *link_grib_tool*: runs the linking tool for GRIB input files
- *ungrib*: runs the ungrib tool
- *metgrid*: runs the metgrid tool



## Copyright & Licensing

This software has been developed by the [Research IT](https://research-it.manchester.ac.uk/) 
at the [University of Manchester](https://www.manchester.ac.uk/).

Copyright 2022 [University of Manchester, UK](https://www.manchester.ac.uk/)

Licensed under the MIT license, see the LICENSE file for details.

