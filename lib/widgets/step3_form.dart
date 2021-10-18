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
  PlatformFile? _path_dniF ;
  PlatformFile? _path_dniT ;
  PlatformFile? _path_C ;
  PlatformFile? _path_CE ;
  PlatformFile? aux ;
  String? _fileName0;
  String? _fileName1;
  String? _fileName2;
  String? _fileName3;
  var listWidgets = <Widget>[];
  File? image;
  late String _studyCenter;

  GlobalKey<FormState> _formkey = GlobalKey();
  _save() {
    final isValid = _formkey.currentState?.validate();
    if(_path_dniF!=null&&_path_dniT!=null&&_path_C!=null&&_path_CE!=null) {
      _paths.add(_path_dniF!);
      _paths.add(_path_dniT!);
      _paths.add(_path_C!);
      _paths.add(_path_CE!);
    }else{
      final message = 'Debe subir todos los documentos.';
      final snackBar = SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          message,
          style: TextStyle(fontSize: 16.0),
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

  Future pickImage(int pos) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        switch (pos){
          case 0: this._path_dniF=file; break;
          case 1: this._path_dniT=file; break;
          case 2: this._path_C=file; break;
          case 3: this._path_CE=file; break;
        }
        //this._paths.add(file);
        setState(() {

          _fileName0 =
          _path_dniF !=null ? _path_dniF!.name!.toString() : '...';
          _fileName1 =
          _path_dniT !=null ? _path_dniT!.name!.toString() : '...';
          _fileName2 =
          _path_C !=null ? _path_C!.name!.toString() : '...';
          _fileName3 =
          _path_CE !=null ? _path_CE!.name!.toString() : '...';
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

        /*  Text(
            "Cras a urna magna.Quisque pulvinar risus arcu, non accumsan nunc tincidunt ut.",
            style: TextStyle(
                color: Color(0xFF13AB46),
                fontWeight: FontWeight.w400,
                fontSize: 14.0),
          ),*/

          Text(
            "DNI (Frontal)",
            style: TextStyle(

                color: Color(0xFF13AB46),
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
               textAlign: TextAlign.left,

          ),
          Builder(
            builder: (BuildContext context) => _path_dniF !=null
                ? Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 70.0 ,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _path_dniF==null ? 0 : 1,
                itemBuilder: (BuildContext context, int index) {
                  //final bool isMultiPath = false;
                  final String name = ( _fileName0 ?? '...');

                  return InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      prefixText: name,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      prefixIcon: Icon(Icons.insert_drive_file),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _path_dniF=aux;
                            //_paths.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.transparent,
                  height: 1.0,
                ),
              ),
            )
                : const Divider(
              height: 0.0,
              color: Colors.transparent,
            ),
          ),

          Divider(
            height: _path_dniF==null?8.0:0.0,
            color: Colors.transparent,
          ),
          Visibility(
            visible: _path_dniF ==null,
            child: CustomButton(
              tap: () async {
                pickImage(0);
              },
              text: "Subir Archivo",
              height: queryData.size.height * 0.07,
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
        Divider(
          height: 8.0,
          color: Colors.transparent,
        ),
          Text(
            "DNI (Trasera)",
            style: TextStyle(

                color: Color(0xFF13AB46),
                fontWeight: FontWeight.bold,
                fontSize: 15.0,),
            textAlign: TextAlign.left,
          ),
          Builder(
            builder: (BuildContext context) => _path_dniT !=null
                ? Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 70.0 ,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _path_dniT==null ? 0 : 1,
                itemBuilder: (BuildContext context, int index) {
                  //final bool isMultiPath = false;
                  final String name = ( _fileName1 ?? '...');

                  return InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      prefixText: name,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      prefixIcon: Icon(Icons.insert_drive_file),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _path_dniT=aux;
                            //_paths.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.transparent,
                  height: 0.0,
                ),
              ),
            )
                : const Divider(
              height: 0.0,
              color: Colors.transparent,
            ),
          ),
          Divider(
            height: _path_dniT==null?8.0:0.0,
            color: Colors.transparent,
          ),
          Visibility(
            visible: _path_dniT==null,
            child: CustomButton(
              tap: () async {
                pickImage(1);
              },
              text: "Subir Archivo",
              height: queryData.size.height * 0.07,
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
          Divider(
            height: 8.0,
            color: Colors.transparent,
          ),
          Text(
            "Carné",
            style: TextStyle(

                color: Color(0xFF13AB46),
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
          Builder(
            builder: (BuildContext context) => _path_C !=null
                ? Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 70.0 ,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _path_C==null ? 0 : 1,
                itemBuilder: (BuildContext context, int index) {
                  //final bool isMultiPath = false;
                  final String name = ( _fileName2 ?? '...');

                  return InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      prefixText: name,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      prefixIcon: Icon(Icons.insert_drive_file),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _path_C=aux;
                            //_paths.removeAt(index);
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
              height: 2.0,
              color: Colors.transparent,
            ),
          ),
          Divider(
            height: _path_C==null?8.0:0.0,
            color: Colors.transparent,
          ),
          Visibility(
            visible: _path_C ==null,
            child: CustomButton(
              tap: () async {
                pickImage(2);
              },
              text: "Subir Archivo",
              height: queryData.size.height * 0.07,
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
          Divider(
            height: 16.0,
            color: Colors.transparent,
          ),
          Text(
            "Certificación de su experticia(experto)",
            style: TextStyle(

                color: Color(0xFF13AB46),
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
          Builder(
            builder: (BuildContext context) => _path_CE!=null
                ? Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 70.0 ,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _path_CE==null ? 0 : 1,
                itemBuilder: (BuildContext context, int index) {
                  //final bool isMultiPath = false;
                  final String name = ( _fileName3 ?? '...');

                  return InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      prefixText: name,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      prefixIcon: Icon(Icons.insert_drive_file),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _path_CE=aux;
                            //_paths.removeAt(index);
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
              height: 0.0,
              color: Colors.transparent,
            ),
          ),
          Divider(
            height: _path_CE==null?8.0:0.0,
            color: Colors.transparent,
          ),
          Visibility(
            visible: _path_CE==null,
            child: CustomButton(
              tap: () async {
                pickImage(3);
              },
              text: "Subir Archivo",
              height: queryData.size.height * 0.07,
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
          ),Divider(
            height: 20.0,
            color: Colors.transparent,
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: this.listWidgets,
          // ),
          /*Builder(
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
                    height: 30.0,
                    color: Colors.transparent,
                  ),
          ),*/
         /* Visibility(
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
          ),*/
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
