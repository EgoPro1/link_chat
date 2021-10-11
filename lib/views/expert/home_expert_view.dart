import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/views/expert/patients_expert_view.dart';
import 'package:acceso_camara/views/patient/configuration_patient.dart';
import 'package:acceso_camara/views/patient/method_patient_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeExpertView extends StatelessWidget {
  const HomeExpertView({Key? key}) : super(key: key);

  void showDialogTakePictureOrSelectPicture(BuildContext context) {
    final picker = ImagePicker();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        var image = await picker.pickImage(source: ImageSource.camera);

                        var preferences = await SharedPreferences.getInstance();
                        preferences.setString("temp_patient_image_path", image!.path);

                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MethodPatientView()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: const Color(0xFF13AB46),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Text(
                                  "Tomar foto",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var image = await picker.pickImage(source: ImageSource.gallery);

                        var preferences = await SharedPreferences.getInstance();
                        preferences.setString("temp_patient_image_path", image!.path);

                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MethodPatientView()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Icon(
                                  Icons.photo_size_select_actual,
                                  color: const Color(0xFF13AB46),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Text("Escoger de Galería",
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "CANCELAR",
                        style: const TextStyle(
                            color: const Color(0xFF13AB46),
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    var name;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF13AB46),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              width: 2, color: const Color(0xFF13AB46))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _prefs.getname,
                          style: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 24.0,
                              color: const Color(0xFF13AB46)),
                        ),
                        Text(
                          "Experto",
                          style: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: const Color(0xFF434343)),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      child: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfigurationPatient())))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  InkWell(      
                    onTap: () => {Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientsExpertView()),
                        )},              
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration:
                            BoxDecoration(color: const Color(0xFFEFEFEF)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                'PACIENTES',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset("assets/verde_1.png"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(                    
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration:
                            BoxDecoration(color: const Color(0xFFEFEFEF)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                'EVALUAR',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset("assets/verde_2.png"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialogTakePictureOrSelectPicture(context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration:
                            BoxDecoration(color: const Color(0xFFEFEFEF)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ANALIZAR',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'FOTO',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset("assets/azul_2.png"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(                    
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration:
                            BoxDecoration(color: const Color(0xFFEFEFEF)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                'HISTORIAL',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset("assets/azul_3.png"),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
