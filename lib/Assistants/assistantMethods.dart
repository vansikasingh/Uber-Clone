//import 'dart:js';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uberclone/Assistants/requestAssistant.dart';
import 'package:uberclone/DataHandler/appData.dart';
import 'package:uberclone/Models/address.dart';
//import 'package:uberclone/configMaps.dart';

class AssistantMethods{
  Future<String> searchCoordinateAddress(Position position, context) async{
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyBSY2Aj6QzmXDgyLyqxyNSniF5Tpr1E4oQ";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed"){
      //placeAddress = response["results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];
      placeAddress = st1 + "," + st2 + "," + st3 + "," + st4;



      Address userPickUpAddress = new Address(placeId: '', placeName: '', placeFormattedAddress: '', longitude: 0.0, latitude: 0.0);
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;


      Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
    }

    return placeAddress;
  }
}