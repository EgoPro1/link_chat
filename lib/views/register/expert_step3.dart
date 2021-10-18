import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/services/file_service.dart';
import 'package:acceso_camara/services/user_service.dart';
import 'package:acceso_camara/views/register/register_end_view.dart';
import 'package:acceso_camara/widgets/form_title.dart';
import 'package:acceso_camara/widgets/step3_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PatientStep3 extends StatefulWidget {
  final UserPatient Upatientaux;

  PatientStep3({Key? key, required this.Upatientaux}) : super(key: key);

  @override
  _PatientStep3State createState() => _PatientStep3State(Upatientaux:Upatientaux);
}

class _PatientStep3State extends State<PatientStep3> {
  final UserPatient Upatientaux;
  UserService uService = new UserService();
  _PatientStep3State({required this.Upatientaux});
  var _paths1 = <PlatformFile>[];
  final _prefs = new PreferenciasUsuario();
  FileService fileService= new FileService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF13AB46),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            FormTitle(
              backgroundColor: Color(0xFF13AB46),
              majorText: 'REGISTRO',
              minorText: 'DOCUMENTOS',
              majorColor: Color(0xFF85F28C),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 18.0, left: 18.0, right: 18.0, bottom: 5.0),
              child: Text(
                "Por favor suba los documentos necesarios para poder ser evaluado para que posteriormente pueda ser aceptado",
                style: TextStyle(
                    color: Color(0xFF13AB46),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 18.0, left: 18.0, right: 18.0, bottom: 5.0),
              child: Step3Form(
                buttonColor: Color(0xFF13AB46),
                buttonFunction: (_paths1) async {

                  var result = null;
                  //if(_prefs.getname==null){
                    result = await uService.createUser(Upatientaux);
                  //}


                  var keys= <String>['dniPictureFront','dniPictureBack','carnetPicture','expertisePicture'];
                  var email='';
                  var password='';
                  if(Upatientaux.email!=null) {
                    email=Upatientaux.email!;
                    password=Upatientaux.password!;

                  }
                  Future.delayed(Duration.zero,() async {
                    var res=await fileService.FileExpUpload(_paths1, keys);

                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterEndView(
                        user: "expert",
                      ),
                    ),
                  );
                },
                buttonText: 'ENVIAR',
              ),
            )
          ],
        ),
      ),
    );
  }
}
