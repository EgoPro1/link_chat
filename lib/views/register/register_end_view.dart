import 'dart:async';

import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/services/user_service.dart';
import 'package:acceso_camara/views/home/home_view.dart';
import 'package:acceso_camara/views/expert/home_expert_view.dart';
import 'package:acceso_camara/views/login/login_view.dart';
import 'package:acceso_camara/views/patient/home_patient_view.dart';
import 'package:acceso_camara/widgets/login_form.dart';
import 'package:flutter/material.dart';

class RegisterEndView extends StatelessWidget {
  final String user;
  const RegisterEndView({Key? key, this.user = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    UserService uService = new UserService();
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

          //  var result = null;

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePatientView(),
              ),
            );
          }else{
            _prefs.settoken='';
            Navigator.of(context).pushReplacement(


              MaterialPageRoute(
                builder: (context) => LoginView(

                ),
              ),
            );
          }

        }
        start++;
      },
    );
    return Scaffold(
      backgroundColor:
          this.user == 'patient' ? Color(0xFF1E4DE8) : Color(0xFF9AAA9F),
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
                      : Color(0xFFFFFFFF),
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
                  this.user=='patient'?Icons.check:Icons.alarm_on_rounded,
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
