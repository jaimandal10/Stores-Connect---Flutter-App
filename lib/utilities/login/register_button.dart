import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton({
    this.col, @required this.press,this.txt
  });
  final Color col;
  final String txt;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        color: col,
        borderRadius: BorderRadius.circular(5.0),
        child: MaterialButton(
          onPressed: press,
          minWidth: 300.0,
          height: 42.0,
          child: Text(
            txt,
            style: TextStyle(
              color: Colors.white, fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
