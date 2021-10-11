/*import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/views/register/expert_step3.dart';
import 'package:acceso_camara/widgets/form_title.dart';
import 'package:acceso_camara/widgets/step2_form.dart';
import 'package:flutter/material.dart';

class ExpertStep2 extends StatefulWidget {
  ExpertStep2({Key? key}) : super(key: key);
  UserPatient Uexpert2=new UserPatient();
  @override
  _ExpertStep2State createState() => _ExpertStep2State();
}

class _ExpertStep2State extends State<ExpertStep2> {
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
              backgroundColor: Color(0xFF13AB46),
              majorText: 'REGISTRO',
              minorText: 'INFORMACIÓN ADICIONAL',
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
              child: Step2Form(
                buttonColor: Color(0xFF13AB46),
                buttonFunction: (Userexpert2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientStep3()),
                  );
                },
                buttonText: 'SIGUIENTE',
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/