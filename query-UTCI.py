import cdsapi

client = cdsapi.Client()
dataset = 'derived-utci-historical'
out = ''
request = lambda year, month, day: {
        'variable': 'universal_thermal_climate_indexp',
        'year': year,
        'month': month,
        'day': day,
        'product_type': 'intermediate_dataset',
        'version': '1.0'
        }

client.retrieve(dataset, request, out)
