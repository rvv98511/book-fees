import 'package:flutter/material.dart';

class TextAndTextFieldWidget extends StatelessWidget {
  final String textString, hintText;
  final textController, typeInput;
  FocusNode? focusNode;
  TextAndTextFieldWidget({Key? key, required this.textString, required this.textController, required this.hintText, required this.typeInput, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(textString)),
          Expanded(
            flex: 3,
              child: TextField(
                controller: textController,
                keyboardType: typeInput,
                decoration: InputDecoration(
                  hintText: hintText
                ),
                focusNode: focusNode
              )),
        ],
      ),
    );
  }
}
