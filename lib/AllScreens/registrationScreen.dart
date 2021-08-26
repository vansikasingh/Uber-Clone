import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uberclone/All%20Widgets/progressDialog.dart';
import 'package:uberclone/AllScreens/loginScreen.dart';
import 'package:uberclone/AllScreens/mainscreen.dart';
import 'package:uberclone/main.dart';

class RegistrationScreen extends StatelessWidget {
  //const RegistrationScreen({Key? key}) : super(key: key);

  static const String idScreen = "register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              SizedBox(
                height:30.0,
              ),
              Image(
                image: AssetImage("images/logo.png"),
                width:390.0,
                height:250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height:1.0,
              ),
              Text(
                "Register as a Rider",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand-Bold"),
                textAlign:TextAlign.center,
              ),
              Padding(
                padding:EdgeInsets.all(20.0),
                child:Column(
                  children:[
                    SizedBox(
                      height:1.0,
                    ),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration:InputDecoration(
                        labelText:"Name",
                        labelStyle: TextStyle(
                          fontSize:14.0,
                        ),
                        hintStyle:TextStyle(
                          color:Colors.grey,
                          fontSize:10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:InputDecoration(
                        labelText:"Email",
                        labelStyle: TextStyle(
                          fontSize:14.0,
                        ),
                        hintStyle:TextStyle(
                          color:Colors.grey,
                          fontSize:10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:1.0,
                    ),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration:InputDecoration(
                        labelText:"Phone",
                        labelStyle: TextStyle(
                          fontSize:14.0,
                        ),
                        hintStyle:TextStyle(
                          color:Colors.grey,
                          fontSize:10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:1.0,
                    ),
                    TextField(
                        controller: passwordTextEditingController,
                        obscureText: true,
                        decoration:InputDecoration(
                          labelText:"Password",
                          labelStyle: TextStyle(
                            fontSize:14.0,
                          ),
                          hintStyle:TextStyle(
                            color:Colors.grey,
                            fontSize:10.0,
                          ),
                        )
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(nameTextEditingController.text.length < 3){
                          displayToastMessage("Name must be atleast 3 characters", context);
                        }
                        else if(!emailTextEditingController.text.contains("@")){
                          displayToastMessage("Email Address is not valid", context);
                        }
                        else if(phoneTextEditingController.text.isEmpty){
                          displayToastMessage("Phone Number is mandatory", context);
                        }
                        else if(passwordTextEditingController.text.length < 6){
                          displayToastMessage("Password must be atleast 6 characters", context);
                        }
                        else {
                          registerNewUser(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.yellow),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      child: Container(
                        height:50.0,
                        child:Center(
                          child:Text(
                            "Create an Account",
                            style:TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: "Brand-Bold",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed:() {
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child:Text(
                  "Already have an Account? Login Here.",
                  style:TextStyle(
                    color:Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    showDialog(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "Registering, Please wait...",);
        }
    );
    final User firebaseUser = (
        await _firebaseAuth
            .createUserWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text
        ).catchError((errMsg){
          Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;
    if(firebaseUser != null)
      {
        Map userDataMap ={
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
        };
        usersRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage("Congratulations, your account has been created", context);
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
      }
    else
      {
        Navigator.pop(context);
        displayToastMessage("New User Account has not been Created", context);
      }
  }
}
displayToastMessage(String message, BuildContext context){
  Fluttertoast.showToast(msg: message);
}
