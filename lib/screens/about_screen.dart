import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  static const String id = 'about_screen';
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'About',
          style: GoogleFonts.lato(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SafeArea(
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.deepOrange[400], width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: ListView(
                children: <Widget>[
                  Container(
                      height: 100,
                      child: Image.asset(
                        'images/Logo_SC_400.png',
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      style:
                          GoogleFonts.abel(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'With almost everything made easy with the help of the internet, doing your everyday shopping yourselves is a pain we don\'t want you to endure. '),
                        TextSpan(
                            text: 'Stores Connect ',
                            style: GoogleFonts.abel(
                                color: Colors.deepOrange[400], fontSize: 20)),
                        TextSpan(
                            text:
                                'lets you shop from your nearby stores, from the comforts of your home. We look forward to make your experience with us hassle free and hope to save your time. So, let us be your one stop shop for your everyday goods and more.'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'We also provide users the oppurtunity to set up their own shop on our app, no matter how small they are. If you\'re selling delicious food from your home, or embroidery, we\'ve got you covered. Register to be a seller on the app and you\'re ready to set up your online store. For free!!',
                    style: GoogleFonts.abel(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'We at Stores Connect aim to provide the best experince for our users. We\'re committed to making your shopping and selling easier and hassle free, and we will continue to work towards this goal.',
                    style: GoogleFonts.abel(color: Colors.black,fontSize: 20),
                  ),
                  SizedBox(height: 20,),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style:
                          GoogleFonts.abel(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Stores',
                            style: GoogleFonts.abel(
                                color: Colors.deepOrange[400])),
                        TextSpan(
                          text: ' Connect',
                        ),
                      ],
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
