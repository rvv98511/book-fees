import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String titleDialog, messageDialog, negativeButtonText, positiveButtonText;
  final onNegativePress, onPositivePress;
  const AlertDialogWidget({Key? key, required this.titleDialog, required this.messageDialog, required this.negativeButtonText, required this.positiveButtonText, required this.onNegativePress, required this.onPositivePress}) : super(key: key);

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
            onPressed: onNegativePress,
            child: Text(negativeButtonText)
        ),
        TextButton(
            onPressed: onPositivePress,
            child: Text(positiveButtonText)
        ),
      ],
    );
  }
}
