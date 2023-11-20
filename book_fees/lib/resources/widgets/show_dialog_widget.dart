import 'package:flutter/material.dart';

class ShowDialogWidget extends StatelessWidget {
  final String titleDialog, messageDialog, closeButtonText;
  final onClosePress;
  const ShowDialogWidget({Key? key, required this.titleDialog, required this.messageDialog, required this.closeButtonText, required this.onClosePress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleDialog),
      content: Text(messageDialog),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      actions: <Widget>[
        TextButton(
            onPressed: onClosePress,
            child: Text(closeButtonText)
        )
      ],
    );
  }
}
