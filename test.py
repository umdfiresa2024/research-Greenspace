import cdsapi
 
client = cdsapi.Client()
   
dataset = 'reanalysis-era5-pressure-levels'
request = {
     'product_type': ['reanalysis'],
     'variable': ['geopotential'],
     'year': ['2024'],
     'month': ['03'],
     'day': ['01'],
     'time': ['13:00'],
     'pressure_level': ['1000'],
     'data_format': 'grib',     # Supported format: grib and netcdf. Default: grib
}
target = 'download.grib'        # Output file. Adapt as you wish.
client.retrieve(dataset, request, target)
