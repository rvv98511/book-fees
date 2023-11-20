import '../views/my_home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SellBookOnline());
}

class SellBookOnline extends StatelessWidget {
  const SellBookOnline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomeScreen(),
    );
  }
}
