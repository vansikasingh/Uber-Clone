import 'package:flutter/cupertino.dart';
import 'package:uberclone/Models/address.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier{

    Address ? pickUpLocation;

  void updatePickUpLocationAddress(Address pickUpAddress){
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}