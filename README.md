# Casechek
This is a project for a CaseChek Interview. This project required me to use the [chicago restaurants API](https://data.cityofchicago.org/resource/cwig-ma7x.json) to create an app. 
I used this api to build an application that displays all the restaurants in a tableview with a hidden search bar that the user can pull down to search for their desired Restaurant. The user can also click any of the cells to get a more detailed view of the restaurant along with a mapview that can connect to Maps for directions. 

## Getting Started
you will need
* Xcode 9.2. 
* CocoaPods
### Instalation Guide.
- download a zip of this git project by using the Download Zip button. 
- place project in desired Directory on computer (suggestion use desktop so it is easy to see)
- open a terminal window and use the following commands

```
$ sudo gem install cocoapods
```
- once installed cd into your project directory 
```
$ cd '/directory/path'
```
- after you are in the project file directory type 

```
$ pod install
```
- now open the .xcworkspace file from the project directory
- make sure the simulator is selected to iphone 8 plus in the top left hand side of the window. 
- press command+r or press the little play button on the top left hand side of the window to run the application on the simulator. 


### NOTE
maps does not pick up your location correctly on simulator so if you navigate to maps it might not be able to figure out a route. To see this feature side load the application on to a test device. 
here is a [link](https://www.twilio.com/blog/2018/07/how-to-test-your-ios-application-on-a-real-device.html) that explains how to do so.
