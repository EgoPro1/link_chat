import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.tap,
      required this.text,
      required this.height,
      required this.radius,
      required this.fontSize,
      this.fontWeight,
      this.textColor,
      this.backgroundColor,
      this.letterSpacing,
      this.padding,
      this.margin})
      : super(key: key);

  final GestureTapCallback tap;
  final String text;
  final double height;
  final double radius;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? backgroundColor;
  final double? letterSpacing;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: double.infinity,
        height: this.height,
        padding: this.padding,
        margin: this.margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing),
        ),
      ),
    );
  }
}
