import 'dart:io';
import 'dart:ui';
import 'package:acceso_camara/chat/chat.dart';
import 'package:acceso_camara/models/history_item_response.dart';
import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/services/file_service.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/views/login/login_view.dart';
import 'package:acceso_camara/views/register/expert_step3.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationPatient extends StatefulWidget {
  ConfigurationPatient({Key? key}) : super(key: key);

  @override
  _ConfigurationPatientState createState() => _ConfigurationPatientState();
}

class _ConfigurationPatientState extends State<ConfigurationPatient> {
  final _prefs = new PreferenciasUsuario();
  //temporal
  final picker = ImagePicker();
  FileService fileService= new FileService();
  //temporal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(
              "CONFIGURATION",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: _prefs.getrol=='patient'?Color(0xFF1E4DE8):Color(
                          0xFF13AB46), shape: BoxShape.rectangle),
                  child: Text(
                    "\n        Cuenta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.build,
                    color: _prefs.getrol=='patient'?Color(0xFF1E4DE8):Color(
                        0xFF13AB46),
                  ),
                  title: Text("Información personal"),
                  onTap: () async {/*
                    if(_prefs.getrol=='expert') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PatientStep3())
                      );
                    }*/
                  },

                ),
                ListTile(
                  leading: Icon(
                    Icons.lock_rounded,
                    color: _prefs.getrol=='patient'?Color(0xFF1E4DE8):Color(
                        0xFF13AB46),
                  ),
                  title: Text("Pago"),
                  onTap: () async {
                    DiagnosisData diagnosisInfo=new DiagnosisData();

                    if(_prefs.getrol=='expert') {
                    /*  UserPatient Upatientaux= new UserPatient();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientStep3(
                            Upatientaux: Upatientaux,

                          ),
                        )
                      );*/
/*
                      var image;
                      image =
                      await picker.pickImage(source: ImageSource.gallery);
                      var preferences = await SharedPreferences.getInstance();
                      preferences.setString(
                          "temp_patient_image_path", image!.path);
                      var _image = File(image.path);
                      var res = await fileService.ImageUpload(_image,'profilePicture' );
                      Navigator.pop(context);*/

                    }
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen(diagnosisInfo:diagnosisInfo  ,premium: true,resultid:"resultid")),
                    );*/

                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.power_settings_new_rounded,
                    color: _prefs.getrol=='patient'?Color(0xFF1E4DE8):Color(
                        0xFF13AB46),
                  ),
                  title: Text("Cerrar Sesión"),
                  onTap: (){
                    _prefs.settoken = '';
                    _prefs.setrol = '';
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );

                  },
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 50.0,
              decoration: BoxDecoration(
                  color: _prefs.getrol=='patient'?Color(0xFF1E4DE8):Color(
                      0xFF13AB46), shape: BoxShape.rectangle),
              child: Text(
                "\n        Otros",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.notifications,
                color: _prefs.getrol=='patient'?Color(0xFF1E4DE8):Color(
                    0xFF13AB46),
              ),
              title: Text("Notificaciones"),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: _prefs.getrol=='patient'?Color(0xFF1E4DE8):Color(
                    0xFF13AB46),
              ),
              title: Text("Términos y Condiciones"),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: _prefs.getrol=='patient'?Color(0xFF1E4DE8):Color(
                    0xFF13AB46),
              ),
              title: Text("Tutorial"),
            ),
          ],
        ));
  }
}
