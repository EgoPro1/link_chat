import 'package:acceso_camara/constants/strings_resources.dart';
import 'package:acceso_camara/widgets/login_form.dart';
import 'package:flutter/material.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

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
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                  color: Color(0xFF1E4DE8), shape: BoxShape.rectangle),
              child: Center(
                child: Text("INICIA SESIÓN",
                    style: TextStyle(
                        color: Color(0xFF949FFF),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 18.0, left: 18.0, right: 18.0, bottom: 5.0),
              child: Text(
                StringsResources.LOGIN_DESCRIPTION,
                style: TextStyle(
                    color: Color(0xFF1E4DE8),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 18.0, left: 18.0, right: 18.0, bottom: 5.0),
              child: LoginForm(),
            )
          ],
        ),
      ),
    );
  }
}
