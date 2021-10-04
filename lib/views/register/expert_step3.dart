import 'package:acceso_camara/services/file_service.dart';
import 'package:acceso_camara/views/register/register_end_view.dart';
import 'package:acceso_camara/widgets/form_title.dart';
import 'package:acceso_camara/widgets/step3_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PatientStep3 extends StatefulWidget {
  PatientStep3({Key? key}) : super(key: key);

  @override
  _PatientStep3State createState() => _PatientStep3State();
}

class _PatientStep3State extends State<PatientStep3> {
  var _paths1 = <PlatformFile>[];

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
                "Cras a urna magna.Quisque pulvinar risus arcu, non accumsan nunc tincidunt ut.",
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
                buttonFunction: (_paths1) {
                  var res=fileService.FileExpUpload(_paths1, 'dniPicture', 'carnetPicture');
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
