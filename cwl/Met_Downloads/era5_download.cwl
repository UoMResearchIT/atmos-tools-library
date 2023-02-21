cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["python3", "era5_script.py"]

doc: |
  This tool should download ERA5 data from the CDS service. The user will 
  need to pre-register with the CDS service before using this tool. 
  See instructions at: https://cds.climate.copernicus.eu/api-how-to
  
  The required inputs are:
    - cdskey: file containing the CDS API key
    - start/end year/month/day: variables defining start and end dates 
      (can be same day)
    - latitude / longitude edges for domain
  
  Outputs:
    - surface level data (6 hourly, each day, full resolution)
    - pressure level data (6 hourly, each day, 0.5 x 0.5 degree resolution)
  
  If different variables, pressure levels, or output times are needed then
  the enclosed python script template can be modified by hand.

hints:
  SoftwareRequirement:
    packages:
      cdsapi:
        version: 
          - 0.5.1
        specs:
          - https://anaconda.org/conda-forge/cdsapi
  
requirements:
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.cdskey)
        entryname: .cdsapirc
      - entryname: era5_script.py
        entry: |-
          import time
          from datetime import date
          from datetime import timedelta
          import cdsapi
          
          c = cdsapi.Client()
          
          idate = date($(inputs.start_year), $(inputs.start_month), $(inputs.start_day))
          edate = date($(inputs.end_year), $(inputs.end_month), $(inputs.end_day))
          
          while (idate <= edate):
              
              iyear = idate.year
              imonth = idate.month
              iday = idate.day
              
              stryear = "%04d" % (iyear)
              strmonth = "%02d" % (imonth)
              strday = "%02d" % (iday)
              strdate = "%d%02d%02d" % (iyear, imonth, iday)
              
              print(strdate)

              # extract 3D data
              c.retrieve(
                  "reanalysis-era5-pressure-levels",
                  {
                      'product_type': 'reanalysis',
                      'format': 'grib',
                      'year': stryear,
                      'month': strmonth,
                      'day': strday,
                      'variable': [
                          'geopotential', 'temperature', 'relative_humidity',
                          'u_component_of_wind', 'v_component_of_wind',
                      ],
                      'pressure_level': [
                          '30', '50',
                          '70', '100', '125',
                          '150', '175', '200',
                          '225', '250', '300',
                          '350', '400', '450',
                          '500', '550', '600',
                          '650', '700', '750',
                          '775', '800', '825',
                          '850', '875', '900',
                          '925', '950', '975',
                          '1000',
                      ],
                      'time': [
                          '00:00', '06:00', '12:00', '18:00',
                      ],
                      'area': [
                          $(inputs.upper_latitude), $(inputs.left_longitude), 
                          $(inputs.lower_latitude), $(inputs.right_longitude),
                      ],
                      'grid': [0.5, 0.5],
                  },
                  "preslev_"+strdate+".grib")

              # extract surface data
              c.retrieve(
                  'reanalysis-era5-single-levels',
                  {
                      'product_type': 'reanalysis',
                      'format': 'grib',
                      'year': stryear,
                      'month': strmonth,
                      'day': strday,
                      'variable': [
                          '10m_u_component_of_wind', '10m_v_component_of_wind', '2m_dewpoint_temperature',
                          '2m_temperature', 'land_sea_mask', 'mean_sea_level_pressure',
                          'sea_ice_cover', 'sea_surface_temperature', 'skin_temperature',
                          'snow_density', 'snow_depth', 'soil_temperature_level_1',
                          'soil_temperature_level_2', 'soil_temperature_level_3', 'soil_temperature_level_4',
                          'surface_pressure', 'volumetric_soil_water_layer_1', 'volumetric_soil_water_layer_2',
                          'volumetric_soil_water_layer_3', 'volumetric_soil_water_layer_4',
                      ],
                      'time': [
                          '00:00', '06:00', '12:00', '18:00',
                      ],
                      'area': [
                          $(inputs.upper_latitude), $(inputs.left_longitude), 
                          $(inputs.lower_latitude), $(inputs.right_longitude),
                      ],
                  },
                  "surface_"+strdate+".grib")

              # move to next day  
              idate = idate + timedelta(days=1) 
          
inputs:
  cdskey: 
    type: File
    default:
      class: File
      location: .cdsapirc
  start_year: int
  start_month: int
  start_day: int
  end_year: int
  end_month: int
  end_day: int
  north_latitude: int
  south_latitude: int
  west_longitude: int
  east_longitude: int
  

outputs:
  grib_files_atm:
    type:
      type: array
      items: File
    outputBinding:
      glob: "preslev*grib"
  grib_files_sfc:
    type:
      type: array
      items: File
    outputBinding:
      glob: "surface*grib"
