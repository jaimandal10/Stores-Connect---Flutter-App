import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsScreen extends StatelessWidget {

  static const String id = 'contact_us_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 3,
                blurRadius: 3,
              )],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Contact Us',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 20),
                  ),
                  SizedBox(height: 10,),
                  ListTile(
                    title: Text(
                      'service@storescollect.in',
                      softWrap: true,
                      style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '9845680592',
                      softWrap: true,
                      style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

