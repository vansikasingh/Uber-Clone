import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show CameraPosition, CameraUpdate, GoogleMap, GoogleMapController, LatLng, MapType;
import 'package:provider/provider.dart';
import 'package:uberclone/All%20Widgets/Divider.dart';
import 'package:uberclone/AllScreens/aboutScreen.dart';
import 'package:uberclone/AllScreens/loginScreen.dart';
import 'package:uberclone/AllScreens/searchScreen.dart';
import 'package:uberclone/Assistants/assistantMethods.dart';
import 'package:uberclone/DataHandler/appData.dart';


class MainScreen extends StatefulWidget {
  //const MainScreen({Key? key}) : super(key: key);
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late Position currentPosition;
  var geolocator= Geolocator();

  double bottomPaddingOfMap = 0;

  double rideDetailsContainer = 0;
  double searchContainerHeight = 300;

  int _value = 1;

  // void displayRideDetailsContainer() async{
  //   await getPlaceDirection();
  // }

  void locatePosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom:14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods().searchCoordinateAddress(position, context);
    print("This is your Address :: " + address);
  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar:AppBar(
        title: Text("Uber", style: TextStyle(color: Colors.black,),),
      ),
      drawer: Container(
        color: Colors.white,
        width:230.0,
        child: Drawer(
          child: ListView(
            children:[
              Container(
                height: 165.0,
                child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children:[
                    Image.asset(
                      "images/user_icon.png",
                      height:65.0,
                      width:65.0,
                    ),
                    SizedBox(
                      width:16.0
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(
                          "Vansika Singh",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Brand-Bold",
                          ),
                        ),
                        SizedBox(
                            height:6.0,
                        ),
                        Text(
                          "Visit Profile",
                        ),
                      ],
                    ),
                  ],
                ),
                ),
              ),
              DividerWidget(),
              SizedBox(
                height:12.0,
              ),
              ListTile(
                leading:Icon(
                    Icons.history
                ),
                title:Text(
                    "History",
                    style: TextStyle(
                      fontSize:15.0,
                    ),
                ),
              ),
              ListTile(
                leading:Icon(
                    Icons.person
                ),
                title:Text(
                  "Visit Profile",
                  style: TextStyle(
                    fontSize:15.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil((context), AboutScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading:Icon(
                      Icons.info
                  ),
                  title:Text(
                    "About",
                    style: TextStyle(
                      fontSize:15.0,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil((context), LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading:Icon(
                      Icons.info
                  ),
                  title:Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize:15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body:Stack(
        children:[
          GoogleMap(
            padding:EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled:true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated:(GoogleMapController controller){
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
                setState((){
                  bottomPaddingOfMap = 300.0;
                });
                locatePosition();
              },
          ),
          Positioned(
            top:45.0,
            left:22.0,
            child: GestureDetector(
              onTap:() {
                scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow:[
                    BoxShadow(
                      color:Colors.black,
                      blurRadius: 6.0,
                      spreadRadius:0.5,
                      offset:Offset(0.7,0.7),
                    ),
                  ],
                ),
                child:CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color:Colors.black,
                  ),
                  radius:20.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height:searchContainerHeight,
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft:Radius.circular(18.0),
                  topRight:Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color:Colors.black,
                    blurRadius:16.0,
                    spreadRadius:0.5,
                    offset:Offset(0.7,0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal:24.0,
                  vertical: 18.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height:6.0
                    ),
                    Text(
                      "Hi there, ",
                      style:TextStyle(
                          fontSize:12.0
                      ),
                    ),
                  Text(
                    "Where to?",
                    style:TextStyle(
                        fontSize:20.0,
                        fontFamily: "Brand-Bold",
                    ),
                  ),
                    SizedBox(
                        height:20.0
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color:Colors.black54,
                              blurRadius:6.0,
                              spreadRadius:0.5,
                              offset:Offset(0.7,0.7),
                            ),
                          ],
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children:[
                              Icon(Icons.search,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                  width:10.0
                              ),
                              Text(
                                "Search Drop Off",
                              ),
                            ]
                          ),
                        )
                      ),
                    ),
                    SizedBox(
                        height:24.0
                    ),
                    Row(
                      children:[
                        Icon(
                          Icons.home,
                          color:Colors.grey,
                        ),
                        SizedBox(
                            width:12.0
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(
                              Provider.of<AppData>(context).pickUpLocation != null
                                  ? Provider.of<AppData>(context).pickUpLocation!.placeName : "Add Home",
                            ),
                            SizedBox(
                                height:4.0
                            ),
                            Text(
                              "Your living Home Address",
                              style:TextStyle(
                                color: Colors.black54,
                                fontSize:12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                        height:10.0
                    ),
                    DividerWidget(),
                    SizedBox(
                        height:16.0
                    ),
                    Row(
                      children:[
                        Icon(
                          Icons.work,
                          color:Colors.grey,
                        ),
                        SizedBox(
                            width:12.0
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(
                              "Add Work",
                            ),
                            SizedBox(
                                height:4.0
                            ),
                            Text(
                              "Your Office Address",
                              style:TextStyle(
                                color: Colors.black54,
                                fontSize:12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left:0.0,
            right:0.0,
            child:Container(
              height:300,
              decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset:Offset(0.7,0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:16.0),
                child: Column(
                  children:[
                    SizedBox(height:35.0,),
                    Container(
                      width: double.infinity,
                      color: Colors.black54,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:16.0),
                        child: Row(
                          children:[
                            Image.asset("images/taxi.png", height:70.0, width: 80.0,),
                            SizedBox(width:16.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text("Car", style: TextStyle(
                                  color: Colors.white,
                                  fontSize:20.0,
                                  fontFamily: "Brand-Bold",
                                ),
                                ),
                                Text("10km", style: TextStyle(
                                  fontSize:15.0,
                                  color: Colors.white,
                                ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                    SizedBox(
                      height:45.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                      ),
                      child: Row(
                        children:[
                          Icon(
                            FontAwesomeIcons.moneyCheckAlt,
                            size: 18.0,
                            color: Colors.black54,),
                          SizedBox(
                            width: 16.0,
                          ),
                          DropdownButton(
                              hint: Text("Select Payment Option"),
                            items: [
                              DropdownMenuItem(
                            child: Text("Paytm"),
                            value: 1,
                          ),
                            DropdownMenuItem(
                              child: Text("Cash"),
                              value: 2,
                            ),
                              DropdownMenuItem(
                                child: Text("Credit Card"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("Paypal"),
                                value: 4,
                              ),
                              DropdownMenuItem(
                                child: Text("Debit Card"),
                                value: 5,
                              ),
                          ],
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                });
                              },
                          ),
                          SizedBox(
                              width:6.0,
                          ),
                          // Icon(
                          //   Icons.keyboard_arrow_down,
                          //   color:Colors.black54,
                          //   size:16.0,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height:20.0,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          print("clicked");
                        },
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[Text("Request",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight:FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                              Icon(
                                FontAwesomeIcons.taxi,
                                color: Colors.black,
                                size: 26.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //SizedBox(
                      //height:120.0,
                    //),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}

