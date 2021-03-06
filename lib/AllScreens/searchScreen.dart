import 'package:flutter/material.dart';
import 'package:uberclone/Assistants/requestAssistant.dart';
import 'package:uberclone/configMaps.dart';
// import 'package:provider/provider.dart';
// import 'package:uberclone/DataHandler/appData.dart';

class SearchScreen extends StatefulWidget {
  //const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //String placeAddress = Provider.of<AppData>(context).pickUpLocation!.placeName ?? "";
    return Scaffold(
      body: Column(
        children:[
        Container(
          height:280.0,
          decoration: BoxDecoration(
            color: Colors.yellow,
            boxShadow:[
            BoxShadow(
              color: Colors.black,
              blurRadius: 6.0,
              spreadRadius: 0.5,
              offset: Offset(0.7,0.7),
            ),
            ],
          ),
          child: Padding(
            padding:EdgeInsets.only(
                left:25.0,
                top:20.0,
                right: 25.0,
                bottom:20.0
            ),
            child: Column(
              children:[
                SizedBox(
                    height: 25.0
                ),
                Stack(
                  children:[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                    },
                        child: Icon(
                            Icons.arrow_back),
                    ),
                    Center(
                      child: Text(
                          "Set Drop Off",
                          style: TextStyle(
                              fontSize:18.0,
                              fontFamily: " Brand-Bold",
                          ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 30.0
                ),
                Row(
                  children:[
                    Image.asset("images/pickicon.png",
                      height: 16.0,
                    width:16.0,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                        height: 18.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child:Padding(
                          padding:EdgeInsets.all(3.0),
                          child: TextField(
                            style:TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: ("PickUp Location"),
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.black,
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left: 12.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 30.0
                ),
                Row(
                  children:[
                    Image.asset("images/desticon.png",
                      height: 16.0,
                      width:16.0,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                        height: 18.0
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child:Padding(
                          padding:EdgeInsets.all(3.0),
                          child: TextField(
                            onChanged: (val){
                              findPlace(val);
                            },
                            style:TextStyle(color: Colors.white),
                            controller: dropOffTextEditingController,
                            decoration: InputDecoration(
                              hintText: "Where to?",
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.black,
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left: 11.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
          ],
      )
    );
  }
  void findPlace(String placeName) async{
    if(placeName.length>1){
      String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890";

      var res =  await RequestAssistant.getRequest(autoCompleteUrl);

      if(res == "failed"){
        return;
      }
      print("Places Prediction Response :: ");
      print(res);
    }
  }
}
