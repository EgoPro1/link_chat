


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

String ?finalEmail;
class SSCREEN extends StatefulWidget {
  @override
  _SSCREENState createState() => new _SSCREENState();
}

class _SSCREENState extends State<SSCREEN> {
  Future getValidationData()async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var obtainedEmail=sharedPreferences.getString('email');
    setState(() {
      finalEmail=obtainedEmail;
    });
    print(finalEmail);

  }
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 8,
      navigateAfterSeconds:(){


      },
      image: new Image.asset(
          'assets/loading.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}