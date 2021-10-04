import 'package:acceso_camara/views/login/login_view.dart';
import 'package:acceso_camara/views/register/expert_step1.dart';
import 'package:acceso_camara/views/register/expert_step11.dart';
import 'package:acceso_camara/views/register/patient_step1.dart';
import 'package:flutter/material.dart';

import 'expert_step3.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Text(
                  "REGISTRARSE COMO",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.0),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                children: [
                  InkWell(
                    onTap: () => setState(() => selectedIndex = 0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: queryData.size.height * 0.24,
                        decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? const Color(0xFF1E4DE8)
                                : const Color(0xFFEFEFEF)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'PACIENTE',
                                    style: TextStyle(
                                      color: selectedIndex == 0
                                          ? Colors.white
                                          : const Color(0xFF1E4DE8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: selectedIndex == 0
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            selectedIndex == 0
                                ? Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: Icon(
                                    Icons.check,
                                    color: const Color(0xFF1E4DE8),
                                  ),
                                ),
                              ),
                            )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => selectedIndex = 1),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: queryData.size.height * 0.24,
                        decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? const Color(0xFF13AB46)
                                : const Color(0xFFEFEFEF)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'EXPERTO',
                                      style: TextStyle(
                                        color: selectedIndex == 1
                                            ? Colors.white
                                            : const Color(0xFF13AB46),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: selectedIndex == 1
                                                ? Colors.white
                                                : Color(0xFF13AB46)),
                                      ),
                                    ),
                                  ],
                                )),
                            selectedIndex == 1
                                ? Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: Icon(
                                    Icons.check,
                                    color: const Color(0xFF13AB46),
                                  ),
                                ),
                              ),
                            )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (selectedIndex == -1) {
                      } else if (selectedIndex == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientStep1()),
                        );
                      } else {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpertStep11()),
                          // MaterialPageRoute(builder: (context) => PatientStep3()),
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(selectedIndex != -1
                            ? selectedIndex == 0
                            ? const Color(0xFF1E4DE8)
                            : const Color(0xFF13AB46)
                            : const Color(0xFF434343))),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        "ELEGIR",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('¿Ya tienes cuenta?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  child: Text(
                    'Inicia Sesión',
                    style: TextStyle(
                      color: Color(0xFF1E4DE8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
