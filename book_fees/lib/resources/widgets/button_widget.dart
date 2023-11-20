import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final buttonFunction;

  const ButtonWidget({Key? key, required this.buttonText, required this.buttonFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
      child: ElevatedButton(
          onPressed: buttonFunction,
          child: Text(
            buttonText.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold
              )
            ),
          // style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.grey,
          //     foregroundColor: Colors.black
          // )
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.grey; //<-- SEE HERE
                return Colors.grey; // Defer to the widget's default.
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return Colors.black; //<-- SEE HERE
              return Colors.black; // Defer to the widget's default.
            },
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.green; //<-- SEE HERE
                return null; // Defer to the widget's default.
              },
            )
          )
      )
    );
  }
}