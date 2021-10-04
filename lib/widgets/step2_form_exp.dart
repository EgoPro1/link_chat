import 'package:acceso_camara/models/metadata.dart';
import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/widgets/custom_button.dart';
import 'package:acceso_camara/widgets/dropdown_list.dart';
import 'package:acceso_camara/widgets/input_text.dart';
import 'package:flutter/material.dart';

class Step2FormExp extends StatefulWidget {
  final Color buttonColor;
  final void Function(UserPatient Upatient) buttonFunction;
  final String buttonText;

  Step2FormExp(
      {Key? key,
      required this.buttonColor,
      required this.buttonFunction,
      required this.buttonText})
      : super(key: key);

  @override
  _Step2FormState createState() => _Step2FormState();
}

class _Step2FormState extends State<Step2FormExp> {
  TextEditingController controller = TextEditingController();
  late String _profesion;
  late String _address;
  String? _bloodType = "O+";
  UserPatient Upatient2=new UserPatient() ;
  Metadata metadata= new Metadata();
  GlobalKey<FormState> _formkey = GlobalKey();
  _save() {
    final isValid = _formkey.currentState?.validate();
    if (isValid == true) {
      _formkey.currentState?.save();

      final message =
          'Profesion: ${Upatient2.profession}\nAddress: ${Upatient2.address}\nBloodType: ${Upatient2.bloodType}\n';
      final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);


      Upatient2.bloodType=metadata.bloodType;
      Upatient2.gender=metadata.gender;
      print(Upatient2.fullName);

      print(Upatient2.birthDate);
      print(Upatient2.email);
      print(Upatient2.password);
      print(Upatient2.profession);
    //  print(Upatient2.bloodType);
      print(Upatient2.bloodType);
      print(Upatient2.gender);
      print(Upatient2.skin);
      print(Upatient2.address);
      widget.buttonFunction(Upatient2);
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
            hint: 'CMP',
            label: 'CMP',
            keyboard: TextInputType.name,
            obsecure: false,
            preIcono: Icon(Icons.account_balance),
            onChanged: (value) => setState(() => Upatient2.cmp = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese su profesión';
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
          AppDropdownInput(
            hintText: "Tipo de Sangre",
            options: ["O-", "O+", "A-", "A+", "B-", "B+", "AB-", "AB+"],
            value:metadata.bloodType,
            onChanged: (String? value) {
              setState(() {
                metadata.bloodType = value;
              });
            },
            getLabel: (String value) => value,
            prefixIcon: Icon(Icons.accessibility),
          ),
          Divider(
            height: 8.0,
            color: Colors.transparent,
          ),
          InputText(
            hint: 'Profesión',
            label: 'Profesión',
            keyboard: TextInputType.name,
            obsecure: false,
            preIcono: Icon(Icons.account_balance),
            onChanged: (value) => setState(() => Upatient2.profession = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese su profesión';
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
          InputText(
            hint: 'Centro de estudio',
            label: 'Centro de estudio',
            keyboard: TextInputType.name,
            obsecure: false,
            preIcono: Icon(Icons.account_balance),
            onChanged: (value) => setState(() => Upatient2.studyCenter = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese su profesión';
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
          InputText(
            hint: 'Especialidad',
            label: 'Especialidad',
            keyboard: TextInputType.name,
            obsecure: false,
            preIcono: Icon(Icons.account_balance),
            onChanged: (value) => setState(() =>Upatient2.speciality = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese su especialidad';
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
          InputText(
            hint: 'Dirección',
            label: 'Dirección',
            keyboard: TextInputType.name,
            obsecure: false,
            preIcono: Icon(Icons.location_on),
            onChanged: (value) => setState(() => Upatient2.address = value),
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Ingrese su dirección';
              } if (data.length < 10) {
                return 'Minimo 10 caracteres';
              } else {
                return null;
              }
            },
            fontSize: 14.0,
          ),
          Divider(
            height: queryData.size.height * 0.20,
            color: Colors.transparent,
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
