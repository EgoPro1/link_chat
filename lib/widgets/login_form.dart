import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/services/user_service.dart';
import 'package:acceso_camara/views/home/home_view.dart';
import 'package:acceso_camara/views/expert/home_expert_view.dart';
import 'package:acceso_camara/views/patient/home_patient_view.dart';
import 'package:acceso_camara/views/register/register_view.dart';
import 'package:acceso_camara/widgets/custom_button.dart';
import 'package:acceso_camara/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _prefs = new PreferenciasUsuario();
  late String _email=_prefs.getemail;
  late String _password=_prefs.getpass;
  UserService uService = new UserService();
  GlobalKey<FormState> _formkey = GlobalKey();
  bool hidePassword = true;
  _submit() async{
    final isValid = _formkey.currentState?.validate();
    if (isValid == true) {
      _formkey.currentState?.save();

      final message = 'Email: $_email\nPassword: $_password\n';
      /*final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      final result = await uService.login(_email, _password);
      var rol=result.data?.rol;
      print(result);
      if (result==null) {
      }
      else{
        print(result);

        if(rol=='patient') {

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePatientView(),
          ));
        }
        if(rol=='expert') {
          _prefs.setidexp=result.data!.id!;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeExpertView(),
          ));
        }
      }
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
          InputText(
            hint: 'Correo',
            label: 'Correo',
            keyboard: TextInputType.emailAddress,
            obsecure: false,
            preIcono: Icon(Icons.email),
            onChanged: (value) => setState(() => _email = value),
            validator: (data) {
              final pattern =
                  r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
              final regExp = RegExp(pattern);
              if (data == null || data.isEmpty) {
                return 'Ingrese un correo';
              } else if (!regExp.hasMatch(data)) {
                return 'Ingrese un correo valido.';
              } else {
                return null;
              }
            },
            fontSize: 14.0,
          ),
          Divider(
            height: 20.0,
            color: Colors.transparent,
          ),
          TextFormField(
            obscureText: hidePassword,
            decoration: InputDecoration(
              contentPadding:
              new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              hintText: 'Contraseña',
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                iconSize: 25.0,
                onPressed: () => setState(() => hidePassword = !hidePassword),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onChanged: (value) => setState(() => _password = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese una contraseña';
              } else if (data.length < 7) {
                return 'Minimo 7 caracteres';
              } else {
                return null;
              }
            },
          ),
          Divider(
            height: queryData.size.height * 0.20,
            color: Colors.transparent,
          ),
          CustomButton(
            tap: () async{
              FocusScope.of(context).unfocus();
              this._submit();
              //      final SharedPreferences SHPR= await SharedPreferences.getInstance();
              //       SHPR.setString('email', _email);
              //        Get.to(HomeView());
              // salta a la vista siguiente
            },
            fontSize: 14.0,
            height: 80.0,
            radius: 4.0,
            letterSpacing: 2.0,
            text: 'INICIAR SESIÓN',
            textColor: Colors.white,
            backgroundColor: Color(0xFF1E4DE8),
            fontWeight: FontWeight.bold,
          ),
          Divider(
            height: 5.0,
            color: Colors.transparent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('¿Aún no tienes cuenta?'),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterView()),
                  );
                },
                child: Text(
                  'Registrate',
                  style: TextStyle(
                    color: Color(0xFF1E4DE8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
