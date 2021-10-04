import 'package:acceso_camara/models/user.dart';
import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/views/register/register_view.dart';
import 'package:acceso_camara/widgets/custom_button.dart';
import 'package:acceso_camara/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Step1Form extends StatefulWidget {
  final Color buttonColor;
  final void Function( UserPatient Upatient) buttonFunction;

  Step1Form({Key? key, required this.buttonColor, required this.buttonFunction})
      : super(key: key);

  @override
  _Step1FormState createState() => _Step1FormState();
}

class _Step1FormState extends State<Step1Form> {
  TextEditingController controller = TextEditingController();

  UserPatient Upatient1=new UserPatient();

/*  late String _fullName;
  late String _birthDate;
  late String _email;
  late String _password;*/
  late String _confirmPassword;

  GlobalKey<FormState> _formkey = GlobalKey();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  _next() {
    final isValid = _formkey.currentState?.validate();
    if (isValid == true) {
      _formkey.currentState?.save();

      final message =
          'Fullname: ${Upatient1.fullName} \nBirthDate: ${Upatient1.birthDate}\nEmail: ${Upatient1.email}\nPassword: ${Upatient1.password}\nConfirmPassword: $_confirmPassword\n';
      final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => widget.view()),
      // );
      print(Upatient1.fullName);
      print(Upatient1.birthDate);
      print(Upatient1.email);
      print(Upatient1.password);
      print(Upatient1.profession);
      print(Upatient1.bloodType);
      print(Upatient1.gender);
      print(Upatient1.skin);
      print(Upatient1.address);
      widget.buttonFunction(Upatient1);
    }
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
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
            hint: 'Nombre completo',
            label: 'Nombre completo',
            keyboard: TextInputType.name,
            preIcono: Icon(Icons.person),
            onChanged: (value) => setState(() => Upatient1.fullName = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese su Nombre Completo';
              }
              return null;
            },
            fontSize: 14.0,
          ),
          Divider(
            height: 8.0,
            color: Colors.transparent,
          ),

          TextFormField(
            controller: controller,
            maxLines: 1,
            enableInteractiveSelection: false,
            decoration: new InputDecoration(
              hintText: 'Fecha de Nacimiento',
              labelText: 'Fecha de Nacimiento',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              prefixIcon: Icon(Icons.event),
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            ),
            onTap: () async {
              DateTime? _dateTime;
              FocusScope.of(context).requestFocus(new FocusNode());

              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2200),
              ).then((date) {
                _dateTime = date;
              });
              setState(() {
                controller.text = _dateTime == null
                    ? ''
                    : DateFormat('dd/MM/yyyy').format(_dateTime!);
                Upatient1.birthDate = controller.text;
              });
            },
            validator: (data) {
              if (data == null || data.trim().isEmpty) {
                return 'Ingrese un fecha';
              }
            },
          ),
          Divider(
            height: 8.0,
            color: Colors.transparent,
          ),
          InputText(
            hint: 'Correo',
            label: 'Correo',
            keyboard: TextInputType.emailAddress,
            obsecure: false,
            preIcono: Icon(Icons.email),
            onChanged: (value) => setState(() => Upatient1.email= value),
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
            height: 8.0,
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
            onChanged: (value) => setState(() => Upatient1.password = value),
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
            height: 8.0,
            color: Colors.transparent,
          ),
          TextFormField(
            obscureText: hideConfirmPassword,
            decoration: InputDecoration(
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              hintText: 'Confirmar Contraseña',
              labelText: 'Confirmar Contraseña',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                iconSize: 25.0,
                onPressed: () =>
                    setState(() => hideConfirmPassword = !hideConfirmPassword),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onChanged: (value) => setState(() => _confirmPassword = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese una contraseña';
              } else if (data.length < 7) {
                return 'Minimo 7 caracteres';
              } else if (Upatient1.password != data) {
                return 'La contraseñas deben ser iguales';
              } else {
                return null;
              }
            },
          ),
          Divider(
            height: queryData.size.height * 0.05,
            color: Colors.transparent,
          ),
          CustomButton(
            tap: () {
              FocusScope.of(context).unfocus();
              this._next();
              // salta a la vista siguiente
            },
            fontSize: 14.0,
            height: 80.0,
            radius: 4.0,
            letterSpacing: 2.0,
            text: 'SIGUIENTE',
            textColor: Colors.white,
            backgroundColor: widget.buttonColor,
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
