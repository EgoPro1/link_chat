import 'package:acceso_camara/services/user_service.dart';
import 'package:acceso_camara/views/login/login_view.dart';
import 'package:acceso_camara/views/register/register_view.dart';
import 'package:acceso_camara/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  UserService uService = new UserService();



  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFEFEFEF),
          child: ListView(
            // physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
                top: queryData.size.height * 0.15,
                left: 18.0,
                right: 18.0,
                bottom: 30.0),
            children: <Widget>[
              Container(
                height: queryData.size.height * 0.50,
                width: 80.0,
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      image: DecorationImage(
                          image: AssetImage('assets/home_logo.png'),
                          fit: BoxFit.scaleDown),
                      shape: BoxShape.circle),
                ),
              ),
              Divider(
                height: 60.0,
                color: Colors.transparent,
              ),
              CustomButton(
                fontSize: 14.0,
                height: 80.0,
                radius: 4.0,
                letterSpacing: 2.0,
                text: 'INICIAR SESIÓN',
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
                textColor: Colors.white,
                backgroundColor: Color(0xFF1E4DE8),
                fontWeight: FontWeight.bold,
              ),
              Divider(height: 8.0),
              CustomButton(
                fontSize: 14.0,
                height: 80.0,
                radius: 4.0,
                letterSpacing: 2.0,
                text: 'REGISTRATE',
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterView()),
                  );
                },
                textColor: Colors.white,
                backgroundColor: Color(0xFF434343),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
