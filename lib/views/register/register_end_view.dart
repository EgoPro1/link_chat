import 'dart:async';

import 'package:acceso_camara/views/home/home_view.dart';
import 'package:acceso_camara/views/expert/home_expert_view.dart';
import 'package:acceso_camara/views/patient/home_patient_view.dart';
import 'package:flutter/material.dart';

class RegisterEndView extends StatelessWidget {
  final String user;
  const RegisterEndView({Key? key, this.user = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    const oneSec = const Duration(seconds: 1);
    int start = 0;

    new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 2) {
          timer.cancel();
          if(this.user=='patient'){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePatientView(),
              ),
            );
          }else{
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeExpertView(),
              ),
            );
          }

        }
        start++;
      },
    );
    return Scaffold(
      backgroundColor:
          this.user == 'patient' ? Color(0xFF1E4DE8) : Color(0xFF13AB46),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "REGISTRO",
              style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                  color: this.user == 'patient'
                      ? Color(0xFF949FFF)
                      : Color(0xFF85F28C),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "COMPLETADO",
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Container(
                width: queryData.size.width * 0.25,
                height: queryData.size.width * 0.25,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 2, color: Colors.white),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 70.0,
                ),
              ),
            ),
            Text(
              "Lorem dolor sit amet consecteur \n adipsicing elit, sed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
