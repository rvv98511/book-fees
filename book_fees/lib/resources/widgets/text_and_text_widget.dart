import 'package:flutter/material.dart';

class TextAndTextWidget extends StatelessWidget {
  final String textString, textContentBox;
  final Color colorBackgroundContentBox;
  final TextAlign textAlignment;
  const TextAndTextWidget({Key? key, required this.textString, required this.textContentBox, required this.colorBackgroundContentBox, required this.textAlignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(textString)
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                color: colorBackgroundContentBox,
                child: Text(
                  textContentBox,
                  textAlign: textAlignment,
                ),
              )),
        ],
      ),
    );
  }
}
