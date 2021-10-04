import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hint;
  final Icon? preIcono;
  final Widget? sufIcono;
  final TextInputType keyboard;
  final bool obsecure;
  final void Function(String data)? onChanged;
  final String? Function(String? data)? validator;
  final Color? labelColor;
  final double fontSize;

  const InputText(
      {Key? key,
      this.label = '',
      this.hint = '',
      this.preIcono,
      this.sufIcono,
      this.keyboard = TextInputType.text,
      this.obsecure = false,
      this.onChanged,
      this.validator,
      this.labelColor,
      this.fontSize = 12.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: this.keyboard,
        obscureText: this.obsecure,
        onChanged: this.onChanged,
        validator: this.validator,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          hintText: this.hint,
          labelText: this.label,
          labelStyle: TextStyle(
            color: this.labelColor,
            fontSize: this.fontSize,
          ),
          prefixIcon: this.preIcono,
          suffix: this.sufIcono,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          // border: OutlineInputBorder(
          //   borderSide: new BorderSide(color: Color(0xFFEFEFEF), width: 0.0),
          // ),
        ),
      ),
    );
  }
}
