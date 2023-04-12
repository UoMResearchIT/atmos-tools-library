# Atmospheric Tool Library

This is a library of tool descriptors for atmospheric science relevant tools.

The principle language supported is [Common Workflow Language (CWL)](https://www.commonwl.org/).

## Tools

### WRF

- **create_run_dir**: creates a run directory, from the WRF docker container, for use with WRF and REAL programs
- **real**: runs the REAL program, to create WRF input files
- **wrf**: runs the WRF model

### WPS

- **create_metgrid_dir**: creates a run directory for the metgrid program
- **create_wps_dir**: creates a run directory for general wps use
- **link_grib_tool**: runs the linking tool for GRIB input files
- **ungrib**: runs the ungrib tool
- **metgrid**: runs the metgrid tool

### EMEP

- **link_wrf_tool**: runs a linking tool for EMEP input files taken from WRF
- **emep**: runs the EMEP model

### Met Downloads

- **era5_download**: downloads ERA5 grib files suitable for WPS processing

### general

- **create_dir_from_filelist**: create directory, with a defined name, from a list of files
- **extract_filelist_from_dir**: generates a list of files from a given directory

## Copyright & Licensing

This software has been developed by the [Research IT](https://research-it.manchester.ac.uk/) 
at the [University of Manchester](https://www.manchester.ac.uk/).

Copyright 2022 [University of Manchester, UK](https://www.manchester.ac.uk/)

Licensed under the MIT license, see the LICENSE file for details.

