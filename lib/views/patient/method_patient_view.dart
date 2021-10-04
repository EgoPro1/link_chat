import 'package:acceso_camara/constants/strings_resources.dart';
import 'package:acceso_camara/views/patient/loading_method_patient_view.dart';
import 'package:flutter/material.dart';

class MethodPatientView extends StatefulWidget {
  const MethodPatientView({Key? key}) : super(key: key);

  @override
  _MethodPatientViewState createState() => _MethodPatientViewState();
}

class _MethodPatientViewState extends State<MethodPatientView> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
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
                  "SELECCIONA MÉTODO",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
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
                          height: 200,
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
                                        'MÉTODO 1',
                                        style: TextStyle(
                                            color: selectedIndex == 0
                                                ? Colors.white
                                                : const Color(0xFF1E4DE8),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          StringsResources.METHOD1_DESCRIPTION,
                                          style: TextStyle(
                                              color: selectedIndex == 0
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ],
                                  )),
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
                                                  width: 2,
                                                  color: Colors.white)),
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
                          height: 200,
                          decoration: BoxDecoration(
                              color: selectedIndex == 1
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
                                        'MÉTODO 2',
                                        style: TextStyle(
                                            color: selectedIndex == 1
                                                ? Colors.white
                                                : const Color(0xFF1E4DE8),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          StringsResources.METHOD2_DESCRIPTION,
                                          style: TextStyle(
                                              color: selectedIndex == 1
                                                  ? Colors.white
                                                  : Colors.black),
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
                                                  width: 2,
                                                  color: Colors.white)),
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
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: TextButton(
                      onPressed: selectedIndex == -1
                          ? null
                          : () => {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoadingMethodPatientView(
                                                methodIndex: selectedIndex)))
                              },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              selectedIndex != -1
                                  ? const Color(0xFF1E4DE8)
                                  : const Color(0xFF949FFF))),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          "ELEGIR",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
