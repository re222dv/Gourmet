Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
    'Some Street, Some City, Sweden', [
        {
            latitude: 12.345,
            longitude: 98.765,
            address: 'Some Street, Some City, Sweden',
            # state: 'New York',
            # state_code: 'NY',
            country: 'Sweden',
            country_code: 'SE'
        }
    ]
)
