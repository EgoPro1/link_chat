import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/views/register/patient_step2.dart';
import 'package:acceso_camara/widgets/form_title.dart';
import 'package:acceso_camara/widgets/step1_form.dart';
import 'package:flutter/material.dart';

class PatientStep1 extends StatefulWidget {
  PatientStep1({Key? key}) : super(key: key);
  UserPatient Upatient=new UserPatient();
  UserPatient Upatientaux=new UserPatient();
  @override
  _PatientStep1State createState() => _PatientStep1State();
}

class _PatientStep1State extends State<PatientStep1> {
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
              minorText: 'CUENTA',
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
              child: Step1Form(
                buttonColor: Color(0xFF1E4DE8),
                buttonFunction: (Upatient) {



                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientStep2(Upatient:Upatient)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
