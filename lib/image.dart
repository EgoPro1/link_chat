import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:acceso_camara/builder/tensorflow_service.dart';
import 'package:tflite/tflite.dart';

class Camera extends StatefulWidget {
  Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

// ignore: avoid_init_to_null
late File? photo = null;

class _CameraState extends State<Camera> {
  final picker = ImagePicker();
  late Future _modelLoaded;

  @override
  void initState(){
    _modelLoaded = _loadModel();
  }

  Future<String> _loadModel() async{
    var res = await loadModel("mobilenet_v1_1.0_224.tflite", "mobilenet_v1_1.0_224.txt");
    return res;
  }

  Future<void> _runModel(String picturePath) async{
    if(!kIsWeb){
      var res = await Tflite.runModelOnImage(path: picturePath);
      print(res);
      if(res!.length > 0){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                        child: Text(res[0]["label"])),
                  ],
                ),
        ));
      }
    }
  }

  Future setImage(op) async {
    var pickedFile;
    if (op == 1) {
      // ignore: deprecated_member_use
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      // ignore: deprecated_member_use
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        _runModel(pickedFile.path);
        photo = File(pickedFile.path);
      } else {
        print('No seleccionaste ninguna foto');
      }
    });
  }

  options(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  !kIsWeb? 
                  InkWell(
                    onTap: () {
                      setImage(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Tomar una foto',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(Icons.camera_alt, color: Colors.blue)
                        ],
                      ),
                    ),
                  ) : SizedBox.shrink(),
                  InkWell(
                    onTap: () {
                      setImage(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Selecciona una foto',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(Icons.image, color: Colors.blue)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.red),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Cancelar',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cámara'),
      ),
      body: FutureBuilder(future: _modelLoaded, builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text("ERROR"),
          );
        }

        if(snapshot.hasData){
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          options(context);
                        },
                        child: Text('Selecciona una imagen')),
                    SizedBox(height: 30),
                    // ignore: unnecessary_null_comparison
                    photo == null ? Center() : kIsWeb? Image.network(photo!.path) : Image.file(photo!)
                  ],
                ),
              )
            ],
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );

      })
    );
  }
}
