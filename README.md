# CrimePlace
A simple Objective-C app that allows the user to browse google maps in London, UK and see street crimes that occurred as returned by the UK Police crime location JSON RESTful API.

# Demo 
[![Watch the video](https://img.youtube.com/vi/PCexwSa602w/hqdefault.jpg)](https://youtu.be/https://youtu.be/PCexwSa602w)

# Requirements
1. Using the Google Maps SDK build a simple app with a single Google Maps screen that
is showing London in the UK as a starting point.

2. Request street crimes from the public UK Police API:
* Using the location in the centre of the displayed map.
* Mark up to the top FIVE (5) crimes returned on the visible map with a “marker”.

NOTE: 1 mile radius is default, and “all-crimes” is the default category, use these
defaults for this project, along with the month of 2019-05. 

3. Allow the user to scroll around and update the location,
you can use the built in controls and gestures provided by the SDK, that are similar to
the Google Maps for iOS application. Care should be taken to wait for user input to stop
for 3 seconds before calling the Police API endpoint again and updating the markers.

4. Create a simple modal dialog to display basic details of
the crime (crime category and location details text) and with a way to close the dialog.
