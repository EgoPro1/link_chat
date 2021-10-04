import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/views/expert/home_expert_view.dart';
import 'package:acceso_camara/views/home/home_view.dart';
import 'package:acceso_camara/views/patient/home_patient_view.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Camera(),
//       theme: ThemeData(
//           brightness: Brightness.dark,
//           primaryColor: Colors.grey,
//           accentColor: Colors.grey),
//     ));

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //agregado
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(
      MaterialApp(debugShowCheckedModeBanner: false,home:(prefs.gettoken=='')||(prefs.gettoken==null)? HomeView():(prefs.getrol=='patient')?HomePatientView():HomeExpertView()));
}