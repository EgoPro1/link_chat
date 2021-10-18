import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/user.dart';
import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/services/user_pacient_service.dart';
import 'package:acceso_camara/services/user_service.dart';
import 'package:acceso_camara/views/register/register_end_view.dart';
import 'package:acceso_camara/widgets/form_title.dart';
import 'package:acceso_camara/widgets/step2_form.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class PatientStep2 extends StatefulWidget {
  final UserPatient Upatient;
  PatientStep2({Key? key,required this.Upatient}) : super(key: key);

  @override
  _PatientStep2State createState() => _PatientStep2State(Upatient:Upatient);

}

class _PatientStep2State extends State<PatientStep2> {

  final UserPatient Upatient;
  final _prefs = new PreferenciasUsuario();
  //UserPacientService upService = new UserPacientService();
  UserService uService = new UserService();
  //APIResponse<List<UserPatient>> _apiResponse;
  _PatientStep2State({required this.Upatient});
  late UserPatient Upatientaux=Upatient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF1E4DE8),
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
            // Container(
            //   width: double.infinity,
            //   height: 80.0,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.transparent),
            //     color: Color(0xFF1E4DE8),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Icon(
            //         Icons.minimize_rounded,
            //         color: Colors.white,
            //         size: 60.0,
            //       ),
            //       Icon(
            //         Icons.minimize_rounded,
            //         color: Colors.black,
            //         size: 60.0,
            //       )
            //     ],
            //   ),
            // ),
            FormTitle(
              backgroundColor: Color(0xFF1E4DE8),
              majorText: 'REGISTRO',
              minorText: 'INFORMACIÓN ADICIONAL',
              majorColor: Color(0xFF949FFF),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 18.0, left: 18.0, right: 18.0, bottom: 5.0),
              child: Text(
                "Cras a urna magna.Quisque pulvinar risus arcu, non accumsan nunc tincidunt ut.",
                style: TextStyle(
                    color: Color(0xFF1E4DE8),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 18.0, left: 18.0, right: 18.0, bottom: 5.0),
              child: Step2Form(
                buttonColor: Color(0xFF1E4DE8),
                buttonFunction: (Upatient) async {
                  //  Upatientaux.bloodType=Upatient.bloodType;
                  Upatientaux.skin=Upatient.skin;
                  Upatientaux.gender=Upatient.gender;
                  Upatientaux.studyCenter=Upatient.studyCenter;
                  Upatientaux.bloodType=Upatient.bloodType;
                  Upatientaux.address=Upatient.address;
                  Upatientaux.profession=Upatient.profession;
                  Upatientaux.rol='patient';
                  Upatientaux.cmp='||||';
                  Upatientaux.speciality='||||';
                  print(Upatientaux.fullName);
                  print(Upatientaux.birthDate);
                  print(Upatientaux.email);
                  print(Upatientaux.password);
                  print(Upatientaux.profession);
                  print(Upatientaux.gender);
                  print(Upatientaux.skin);
                  print(Upatientaux.bloodType);
                  print(Upatientaux.studyCenter);
                  print(Upatientaux.rol);
                  print(Upatientaux.address);
                  print(Upatientaux.speciality);
                  print(Upatientaux.cmp);
                  //registra

                  //                us.email=Upatientaux.email;
                  //   us.tipoDoc="Dni";
                  //   us.nroDoc="999654410087";
                  //                 us.password=Upatientaux.password;
                  //                 us.rol="patient";
                  print("ENTRO");

                  var result = null;
                  result = await uService.createUser(Upatientaux);
            /*      print(result.data);
                  String uuid = result.data.substring(9,/*48*/ 45);
                  String rolid= result.data.substring(56,92);
                  String token = result.data.substring(103,result.data.toString().length-2);



                  _prefs.setrolid=rolid;
                  _prefs.setidpat=uuid;
                  _prefs.settoken=token;*/
                  var email='';
                  var password='';
                  if(Upatientaux.email!=null) {
                    email=Upatientaux.email!;
                    password=Upatientaux.password!;
                    result = await uService.login(email,password);
                  }
                  _prefs.setname=Upatientaux.fullName!;

                  /*                 if(result!=null) {
                    print(result.data);
                    print("uuid: ${uuid}");
                    print("token: ${token}");
                  }*/

                  //                 final result2 = await upService.nuevoUsuario(Upatientaux,uuid,token);
                  //final result1 =upService.nuevoUsuario(Upatientaux);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterEndView(
                        user: "patient",
                      ),
                    ),
                  );
                },
                buttonText: 'REGISTRAR',
              ),
            )
          ],
        ),
      ),
    );
  }
}
