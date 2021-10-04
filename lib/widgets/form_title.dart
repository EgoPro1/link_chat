import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({
    Key? key,
    required this.backgroundColor,
    required this.majorText,
    required this.minorText,
    required this.majorColor,
  }) : super(key: key);

  final Color backgroundColor;
  final Color majorColor;
  final String majorText;
  final String minorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.0,
      decoration:
          BoxDecoration(color: this.backgroundColor, shape: BoxShape.rectangle),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
            children: <TextSpan>[
              TextSpan(
                text: this.majorText + "\n",
                style: TextStyle(
                  color: this.majorColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              TextSpan(
                text: this.minorText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
