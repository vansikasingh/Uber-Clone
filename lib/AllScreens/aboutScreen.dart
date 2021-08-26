import 'package:flutter/material.dart';
import 'package:uberclone/AllScreens/mainscreen.dart';

class AboutScreen extends StatefulWidget {
  //const AboutScreen({Key? key}) : super(key: key);

  static const String idScreen= "about";

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body:ListView(
        children:[
          Container(
            height:220,
            child:Center(
              child: Image.asset('images/taxi.png'),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(top:30, left: 24, right:24),
            child: Column(
              children:[
                Text("Uber Clone",
                  style: TextStyle(
                    fontSize:90,
                    fontFamily: "Brand-Bold",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height:30,),

                Text("This app has been developed by Vansika Singh,"
                    "This app offers rides at cheap rates,",
                  style: TextStyle(
                    fontFamily:"Brand-Bold",
                  ),
                  textAlign: TextAlign.center,
                    ),
              ],
            ),
          ),
          SizedBox(height:40,),

          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                ),
            ),
            child: const Text(
              "Go Back",
              style:TextStyle(
                fontSize:18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
