import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String textString;
  final Color textColor;
  final TextAlign textAlignment;
  final widthBox;
  EdgeInsetsGeometry? marginBox;
  TextWidget({Key? key, required this.textString, required this.textColor, required this.textAlignment, required this.widthBox, this.marginBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthBox,
      padding: EdgeInsets.all(5),
      margin: marginBox,
      decoration: BoxDecoration(
        color: Colors.green
      ),
      child: Text(
        textString,
        textAlign: textAlignment,
        style: TextStyle(
          color: textColor
        ),
      ),
    );
  }
}
