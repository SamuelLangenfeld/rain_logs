# Rain Logs

This was a project that I made to show some API work. Rain Logs keeps track of the rainfall at your construction sites. It uses the Google Maps API to find the longitude and latitude of your address, then sends those coordinates to the National Weather Service API to get the rainfall from the last 24 hours and from the last week.

It is online at [rain-logs.herokuapp.com](http://rain-logs.herokuapp.com).

## Walkthrough

Once you've signed up you can create project sites to track by entering a name for the project and an address.

On your project site's page you can click "Updata Precipitation Data" to get the information on your site's closest weather observation station, precipitation over the last 24 hours, and precipitation over the last week.

## Known Issues

This data is not 100% accurate.

The application gets data from the national weather service and parses it, looking for the "precipitaitonLastHour" value. Almost all observation stations give this value, but I have seen some that do not. In that case the precipitation data for your project site will not be updated or entered.

For the most part weather stations report their observations once an hour. The way this application determines the value of the precipitation for the last 24 hours and last week is by taking the last 24 and 168 of these measurements respectively. As long as the observation station has reported only once an hour as normal, your data should be accurate. I have seen observation stations report more than once an hour, but these extra reports do not occur often. This could throw off data for your site as precipitation during an hour could be reported more than once.

I'm working on a solution to the multiple reports per hour from an observation station but at the moment the precipitation data from your site could be off.
