import 'dart:convert';
import 'dart:io';

import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/login_response.dart';
import 'package:acceso_camara/models/user.dart';
import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class FileService with ChangeNotifier {

  // final String _firebaseToken = 'AIzaSyAzIGZax6Pn30zGytZkwyXJdEmsKiRDRc8';
  static const API = 'http://192.168.0.2:3006/signup';
  final _prefs = new PreferenciasUsuario();
  /*static const headers = {
     'apiKey':"_prefs.gettoken",
    'Content-Type': 'application/json'
  };*/


  Future<http.StreamedResponse>ImageUpload( File file,String key) async{
    var token=_prefs.gettoken;
    final url = _prefs.geturl;
    var urlfinal;
    print(token);
    print(_prefs.getidexp);
    print(_prefs.getrolid);
    final headers = {
      'Content-Type':'multipart/form-data',
      //HttpHeaders.contentTypeHeader: 'multipart/form-data',
      'Authorization':'Bearer ${token}'
    };
    if(key=='skinPhoto'&&_prefs.getrol=='patient')
    {
      urlfinal=url + 'patient/${_prefs.getidpat}/skinPhoto';
    }
    if(key=='profilePicture'&&_prefs.getrol=='expert')
    {
      urlfinal=url + 'expert/${_prefs.getrolid}/profilePicture';
    }
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse(urlfinal));
    //add text fields
    request.fields[key] = key;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath(key, file.path);
    //add multipart to request
    request.files.add(pic);
    request.headers.addAll(headers);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    _prefs.setNpath=responseString;
    print(responseString);
    if(response.statusCode==201||response.statusCode==200)
      if(file.path!=null) ;
    return response;
  }


  Future<http.StreamedResponse>FileExpUpload(List<PlatformFile>files,List<String> keys) async{
    var token=_prefs.gettoken;
    final url = _prefs.geturl;
    var urlfinal;
    print(token);
    print(_prefs.getidexp);
    print(_prefs.getrolid);
    final headers = {
      'Content-Type':'multipart/form-data',
      //HttpHeaders.contentTypeHeader: 'multipart/form-data',
      'Authorization':'Bearer ${token}'
    };

      urlfinal=url + 'expert/${_prefs.getrolid}/pictures';

    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse(urlfinal));
    //add text fields

  //  request.fields[key2] = key2;
    //create multipart using filepath, string or bytes
    for(int i=0;i<files.length;i++) {
      request.fields[keys[i]] = keys[i];
      request.files.add(await http.MultipartFile.fromPath(keys[i], files[i].path));
    }
    //add multipart to request
    request.headers.addAll(headers);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    if(response.statusCode==201||response.statusCode==200)
      if(files.length==0) ;
    return response;
  }
  /*
  uploadFileFromDio( File photoFile) async {
    var token=_prefs.gettoken;
    final url = _prefs.geturl;
    var dio = new Dio();
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: '$token',

    };
    FormData formData = new FormData();
    formData.files

    if (photoFile != null &&
    photoFile.path != null &&
    photoFile.path.isNotEmpty) {
    // Create a FormData
    String fileName = basename(photoFile.path);
    print("File Name : $fileName");
    print("File Size : ${photoFile.lengthSync()}");
    formData.add("user_picture", new UploadFileInfo(photoFile, fileName));
    }
    var response = await dio.post("user/manage_profile",
    data: formData,
    options: Options(
    method: 'POST',
    responseType: ResponseType.PLAIN // or ResponseType.JSON
    ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
  }*/
/* Future<String?> uploadImage(filepath) async{

    var token=_prefs.gettoken;
    final url = _prefs.geturl;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: '$token',
    };

    final multipartRequest = new http.MultipartRequest('POST', Uri.parse(url + 'patient/${_prefs.getidpat}/skinPhoto'));
    multipartRequest.headers.addAll(headers);


    multipartRequest.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await multipartRequest.send();
    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);


  }  */



  Future<APIResponse<String>> postSkinPhoto(File item) {
  final bytes=item.readAsBytesSync();
  final data={
    "skinPhoto":base64Encode(bytes)

  };
  var token=_prefs.gettoken;
  final url = _prefs.geturl;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: '$token',
  };
    return http
        .post(Uri.parse(url + 'patient/${_prefs.getidpat}/skinPhoto'),
        headers: headers, body: json.encode(data))
        .then((data) {
      if (data.statusCode == 201) {
        print("FUNCIONA");
        print(data.body);
        return APIResponse<String>(data: data.body);
      }
      return APIResponse<String>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<String>(error: true, errorMessage: 'An error occured'));
  }


  Future<APIResponse<LoginResponse>> login(String uID, String uPwd) {
    final url = _prefs.geturl;
    Userlogin log=new Userlogin();
    log.email=uID;
    log.password=uPwd;
    _prefs.setemail=uID;
    _prefs.setpass=uPwd;
   var headers = {
     'apiKey':"_prefs.gettoken",
    'Content-Type': 'application/json'
  };

    return http
        .post(Uri.parse(url + 'signin'),
        headers: headers, body: json.encode(log.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        final jsonData = json.decode(data.body);
        if (jsonData['rol'] != 'patient'&&jsonData['rol'] != 'expert') {
          return APIResponse<LoginResponse>(
              error: true, errorMessage: 'No existe el usuario');
        }
        _prefs.settoken = jsonData['token'];
        _prefs.setrol = jsonData['rol'];

        return APIResponse<LoginResponse>(
            data: LoginResponse.fromJson(jsonData));
      }
      return APIResponse<LoginResponse>(
          error: true, errorMessage: 'El usuario y/o Contraseña es incorrecto');
    }).catchError((_) => APIResponse<LoginResponse>(
        error: true, errorMessage: 'An error occured'));
  }
}