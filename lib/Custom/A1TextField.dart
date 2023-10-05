import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class A1TextField extends StatelessWidget {

  String labelText;
  TextEditingController tecController;
  bool isPassword;
  double paddingHorizontal = Checkbox.width;
  double paddingVertical = 14;

  A1TextField ({
    required this.labelText,
    required this.tecController,
    required this.isPassword,
    required this.paddingHorizontal,
    required this.paddingVertical,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Flexible(child: SizedBox(width: 450, child: TextField(
        controller: tecController,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
        ),
      ),
      ),
      ),
    );
  }
}