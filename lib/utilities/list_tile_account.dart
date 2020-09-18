import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileAcc extends StatelessWidget {

  ListTileAcc({this.txt,this.goTo,this.icon});

  final String txt;
  final goTo;
  final icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        txt,
        style: GoogleFonts.lato(
          fontSize: 18,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, goTo);
      },
      leading: Icon(icon,color: Colors.black,),
    );
  }
}
