# Uber Clone

This Application is a clone of Uber which is an Application used Worldwide to Book Rides. This Application is Capable of Fetching the User's Real Time and displaying it on the Map on the Home Screen. 

Following is a Demo of the Application:

https://user-images.githubusercontent.com/71205815/131003799-5ab6a1ca-6d92-4f35-af7a-c997223265b0.mp4

### Existing Features

1. User Login and Authentication using Firebase. 
2. Fetches the Real Time Location of the User using Google Maps APIs.
3. Allows the User to Add Drop Off location.
4. Allows the User to Select Payment Method.
5. Allows the user to Signout from the Contents Bar. 

## Android Screenshots 

  Register Screen Page | Login Screen page | Authentication
:-------------------------:|:-------------------------: |:-------------------------:
![](https://user-images.githubusercontent.com/71205815/131004000-802de617-4740-4ee3-8151-fb8ea21d5de5.jpeg)|![](https://user-images.githubusercontent.com/71205815/131004141-a2f87134-8501-4ae4-bbf4-4d3ec71465cb.jpeg) |![](https://user-images.githubusercontent.com/71205815/131004231-1bd69033-2529-4b8c-88dd-3c72ce41312d.jpeg) 

  Home Screen Page | Set DropOff Screen page | Contents Bar
:-------------------------:|:-------------------------: |:-------------------------:
![](https://user-images.githubusercontent.com/71205815/131004516-1343a6e8-ae50-4a4a-aa07-0ef1bf97b8bd.jpeg)|![](https://user-images.githubusercontent.com/71205815/131004609-6aba8f0b-aab9-4889-b9d9-0728e099804f.jpeg) |![](https://user-images.githubusercontent.com/71205815/131004733-58676710-d5e6-496c-8223-bc54aef4ea16.jpeg) 

 About Screen Page | Request Ride | Payment Option
:-------------------------:|:-------------------------: |:-------------------------: 
![](https://user-images.githubusercontent.com/71205815/131004922-f35af92e-0a86-4a33-8499-43d2897329f4.jpeg)|![](https://user-images.githubusercontent.com/71205815/131005068-5591dde3-4685-475e-a574-bb870ca81539.jpeg)|![](https://user-images.githubusercontent.com/71205815/131005177-29bbc4d0-6bee-446d-bb84-8d787924c687.jpeg) 

## Firebase Screenshot

![](https://user-images.githubusercontent.com/71205815/131006071-54d91812-8e08-4c85-802f-88ac19ade91c.png)


## Directory Structure
```
lib
│-- main.dart
│-- configMaps.dart
└───|
    └───All Widgets
    |    │──Divider.dart
    |    │──progressDialog.dart
    └────All Screens
    |     │──aboutScreen.dart
    |     └──loginScreen.dart 
    |     └──mainScreen.dart 
    |     └──profileTabPage.dart 
    |     └──registrationScreen.dart 
    |     └──searchScreen.dart 
    └────Assistants
    |     │──assistantMethods.dart
    |     |──requestAssistant.dart
    └────DataHandler
    |     │──appData.dart
    └────Models
          │──address.dart
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
