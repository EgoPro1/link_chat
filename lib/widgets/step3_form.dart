import 'dart:io';

import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class Step3Form extends StatefulWidget {
  final Color buttonColor;
  final void Function(List<PlatformFile> _paths1) buttonFunction;
  final String buttonText;

  Step3Form(
      {Key? key,
      required this.buttonColor,
      required this.buttonFunction,
      required this.buttonText})
      : super(key: key);

  @override
  _Step3FormState createState() => _Step3FormState();
}

class _Step3FormState extends State<Step3Form> {
  final _prefs = new PreferenciasUsuario();
  //temporal

  TextEditingController controller = TextEditingController();
  var _paths = <PlatformFile>[];
  String? _fileName;
  var listWidgets = <Widget>[];
  File? image;
  late String _studyCenter;

  GlobalKey<FormState> _formkey = GlobalKey();
  _save() {
    final isValid = _formkey.currentState?.validate();
    if (_paths.length == 0) {
      final message = 'Debe subir al menos 1 documento.';
      final snackBar = SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          message,
          style: TextStyle(fontSize: 14.0),
        ),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (isValid == true) {
      _formkey.currentState?.save();

      /* final message = 'StudyCenter: $_studyCenter\n';
      final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      widget.buttonFunction(_paths);
    }
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        this._paths.add(file);
        setState(() {
          _fileName =
              _paths.length != 0 ? _paths.map((e) => e.name).toString() : '...';
        });
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          /*
          InputText(
            hint: 'Centro de Estudios',
            label: 'Centro de Estudios',
            keyboard: TextInputType.name,
            obsecure: false,
            preIcono: Icon(Icons.account_balance),
            onChanged: (value) => setState(() => _studyCenter = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese su centro de estudios';
              } else {
                return null;
              }
            },
            fontSize: 14.0,
          ),*/
          Divider(
            height: 8.0,
            color: Colors.transparent,
          ),
          Text(
            "Cras a urna magna.Quisque pulvinar risus arcu, non accumsan nunc tincidunt ut.",
            style: TextStyle(
                color: Color(0xFF13AB46),
                fontWeight: FontWeight.w400,
                fontSize: 14.0),
          ),
          Divider(
            height: 8.0,
            color: Colors.transparent,
          ),
          Visibility(
            visible: _paths.length == 0,
            child: CustomButton(
              tap: () async {
                pickImage();
              },
              text: "Subir Archivos",
              height: queryData.size.height * 0.20,
              radius: 4.0,
              fontSize: 14.0,
              letterSpacing: 2.0,
              backgroundColor: Color(0xFFEFEFEF),
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'se acepta: .doc, .pdf, .png, .jpg',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Color(0xFF434343),
                ),
              ),
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: this.listWidgets,
          // ),
          Builder(
            builder: (BuildContext context) => _paths.length != 0
                ? Container(
                    margin: EdgeInsets.only(top: 20.0),
                    height: 70.0 * _paths.length,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _paths.length != 0 ? _paths.length : 1,
                      itemBuilder: (BuildContext context, int index) {
                        final bool isMultiPath = _paths.length != 0;
                        final String name = (isMultiPath
                            ? _paths.map((e) => e.name).toList()[index]
                            : _fileName ?? '...');

                        return InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            prefixText: name,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            prefixIcon: Icon(Icons.insert_drive_file),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  _paths.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: Colors.transparent,
                        height: 8.0,
                      ),
                    ),
                  )
                : const Divider(
                    height: 60.0,
                    color: Colors.transparent,
                  ),
          ),
          Visibility(
            visible: _paths.length != 0,
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                prefixIcon: Icon(Icons.insert_drive_file),
                prefixText: 'Subir Archivo',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    pickImage();
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: _paths.length != 0,
            child: Divider(
              height: 30.0,
              color: Colors.transparent,
            ),
          ),
          CustomButton(
            tap: () {
              FocusScope.of(context).unfocus();
              this._save();
              // salta a la vista siguiente
            },
            fontSize: 14.0,
            height: 80.0,
            radius: 4.0,
            letterSpacing: 2.0,
            text: widget.buttonText,
            textColor: Colors.white,
            backgroundColor: widget.buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
