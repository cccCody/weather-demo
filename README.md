## Environment
I developed this demo app with ruby 3.3.0 and rails 7.1.3.2 on Ubuntu 22.04.3 LTS running on windows subsystem for linux on Windows 10 22H2.

## Running 
To get this up and running, clone this project, then run:
```
bundle install
rails server
```

To run tests:
```
rails test
```
## Notes 
* For this exercise, I'm limiting address input to the USA, since caching was specified to be by zip code.
* This uses the default rails in-memory cache, configured with a 30 minute default TTL.

## Data sources:
* [National Weather Service](https://www.weather.gov/documentation/services-web-api)
* [Nominatim from OpenStreetMap](https://nominatim.org/release-docs/latest/api/Overview/)